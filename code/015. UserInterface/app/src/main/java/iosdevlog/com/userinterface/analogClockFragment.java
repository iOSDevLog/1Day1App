package iosdevlog.com.userinterface;

import android.app.Fragment;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AnalogClock;
import android.widget.Button;

public class analogClockFragment extends Fragment {
    Button happyButton;
    Button worldButton;
    Button clockButton;
    AnalogClock myAnalogClock;

    @Override
    public View onCreateView(LayoutInflater analogClock,
                             ViewGroup analogClockLayout, Bundle savedInstanceState) {
        View analogClockView = analogClock.inflate(R.layout.activity_analog,
                analogClockLayout, false);

        myAnalogClock = analogClockView.findViewById(R.id.analogClock);
        happyButton = analogClockView.findViewById(R.id.happyClock);
        happyButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                myAnalogClock.setBackgroundResource(R.drawable.analogclockhoop);
            }
        });
        worldButton = analogClockView.findViewById(R.id.worldClock);
        worldButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                myAnalogClock.setBackgroundResource(R.drawable.worldclockhoop);
            }
        });
        clockButton = analogClockView.findViewById(R.id.simpleClock);
        clockButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                myAnalogClock.setBackgroundResource(R.drawable.goldclockhoop);
            }
        });

        return analogClockView;
    }
}

