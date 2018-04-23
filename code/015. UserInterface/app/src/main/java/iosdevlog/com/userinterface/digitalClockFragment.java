package iosdevlog.com.userinterface;

import android.app.Fragment;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

public class digitalClockFragment extends Fragment {
    @Override
    public View onCreateView(LayoutInflater digitalClock,
                             ViewGroup digClockLayout, Bundle savedInstanceState) {
        return digitalClock.inflate(R.layout.activity_digital, digClockLayout, false);
    }
}
