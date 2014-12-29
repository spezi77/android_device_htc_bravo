package com.android.internal.telephony;

import android.content.Context;
import android.os.Parcel;
import android.telephony.SignalStrength;
import android.os.SystemProperties;
import com.android.internal.telephony.uicc.IccCardApplicationStatus;
import com.android.internal.telephony.uicc.IccCardStatus;

/**
 * Provides SignalStrength correction and force AppTypeSIM for old HTC RIL
 */
public class HtcLegacyRIL extends RIL {

    public HtcLegacyRIL(Context context, int preferredNetworkType, int cdmaSubscription) {
        super(context, preferredNetworkType, cdmaSubscription);
       mQANElements = 4;
    }

    public HtcLegacyRIL(Context context, int preferredNetworkType, int cdmaSubscription, Integer instanceId) {
        super(context, preferredNetworkType, cdmaSubscription, instanceId);
       mQANElements = 4;
    }

    @Override
    protected Object
    responseSignalStrength(Parcel p) {
	SignalStrength signalStrength;
	
	if (needsOldRilFeature("signalstrengthgsm")) {
	    int gsmSignal = p.readInt();
	    int gsmErrRate = p.readInt();
	    signalStrength = new SignalStrength(gsmSignal, gsmErrRate,
									-1, -1, -1, -1, -1, true);
	} else {
	    // Assume this is gsm, but doesn't matter as ServiceStateTracker
	    // sets the proper value.
	    signalStrength = SignalStrength.makeSignalStrengthFromRilParcel(p);
	}
	return signalStrength;
    }
    
    @Override
    public boolean needsOldRilFeature(String feature) {
        String[] features = SystemProperties.get("ro.telephony.ril.config", "").split(",");
	for (String found: features) {
	    if (found.equals(feature))
		return true;
	}
	return false;
    }

    @Override
    protected Object
    responseIccCardStatus(Parcel p) {
	IccCardApplicationStatus appStatus;
	
	boolean oldRil = needsOldRilFeature("icccardstatus");
	IccCardStatus cardStatus = new IccCardStatus();
	cardStatus.setCardState(p.readInt());
	cardStatus.setUniversalPinState(p.readInt());
	cardStatus.mGsmUmtsSubscriptionAppIndex = p.readInt();
	cardStatus.mCdmaSubscriptionAppIndex = p.readInt();
	
	if (!oldRil)
	    cardStatus.mImsSubscriptionAppIndex = p.readInt();
	
	int numApplications = p.readInt();
	
	// limit to maximum allowed applications
	if (numApplications > IccCardStatus.CARD_MAX_APPS) {
	    numApplications = IccCardStatus.CARD_MAX_APPS;
	}
	cardStatus.mApplications = new IccCardApplicationStatus[numApplications];
	oldRil = needsOldRilFeature("apptypesim");
	
	for (int i = 0 ; i < numApplications ; i++) {
	    appStatus = new IccCardApplicationStatus();
	    appStatus.app_type = appStatus.AppTypeFromRILInt(p.readInt());
	    // Seems the simplest way so we dont mess up the parcel
	    if (oldRil) appStatus.app_type = appStatus.AppTypeFromRILInt(1);
	    appStatus.app_state = appStatus.AppStateFromRILInt(p.readInt());
	    appStatus.perso_substate = appStatus.PersoSubstateFromRILInt(p.readInt());
	    appStatus.aid = p.readString();
	    appStatus.app_label = p.readString();
	    appStatus.pin1_replaced = p.readInt();
	    appStatus.pin1 = appStatus.PinStateFromRILInt(p.readInt());
	    appStatus.pin2 = appStatus.PinStateFromRILInt(p.readInt());
	    cardStatus.mApplications[i] = appStatus;
	}
	return cardStatus;
    }

}