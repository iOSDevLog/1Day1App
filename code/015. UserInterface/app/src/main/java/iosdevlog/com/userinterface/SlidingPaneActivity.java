package iosdevlog.com.userinterface;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

public class SlidingPaneActivity extends Activity {
    LinearLayout uiPaneLinearLayout;
    ImageView planetImageView;
    TextView planetText1;
    TextView planetText2;
    TextView planetText3;
    TextView planetText4;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_slidingpane);

        uiPaneLinearLayout = findViewById(R.id.uiPane);
        planetImageView = findViewById(R.id.iv1);
        planetText1 = findViewById(R.id.tv1);
        planetText2 = findViewById(R.id.tv2);
        planetText3 = findViewById(R.id.tv3);
        planetText4 = findViewById(R.id.tv4);

        ImageButton earthButton = findViewById(R.id.ib_earth);
        earthButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View arg0) {
                uiPaneLinearLayout.setBackgroundResource(R.drawable.plasma1080);
                planetImageView.setBackgroundResource(R.drawable.ib_earth_normal);
                planetText1.setText(R.string.planet_name_earth);
                planetText2.setText(R.string.planet_mass_earth);
                planetText3.setText(R.string.planet_grav_earth);
                planetText4.setText(R.string.planet_size_earth);
            }
        });

        ImageButton venusButton = findViewById(R.id.ib_venus);
        venusButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View arg0) {
                uiPaneLinearLayout.setBackgroundResource(R.drawable.plasma720);
                planetImageView.setBackgroundResource(R.drawable.ib_venus_normal);
                planetText1.setText(R.string.planet_name_venus);
                planetText2.setText(R.string.planet_mass_venus);
                planetText3.setText(R.string.planet_grav_venus);
                planetText4.setText(R.string.planet_size_venus);
            }
        });

        ImageButton jupiterButton = findViewById(R.id.ib_jupiter);
        jupiterButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View arg0) {
                uiPaneLinearLayout.setBackgroundResource(R.drawable.plasma480);
                planetImageView.setBackgroundResource(R.drawable.ib_jupiter_normal);
                planetText1.setText(R.string.planet_name_jupiter);
                planetText2.setText(R.string.planet_mass_jupiter);
                planetText3.setText(R.string.planet_grav_jupiter);
                planetText4.setText(R.string.planet_size_jupiter);
            }
        });

        ImageButton neptuneButton = findViewById(R.id.ib_neptune);
        neptuneButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View arg0) {
                uiPaneLinearLayout.setBackgroundResource(R.drawable.stars480);
                planetImageView.setBackgroundResource(R.drawable.ib_neptune_normal);
                planetText1.setText(R.string.planet_name_neptune);
                planetText2.setText(R.string.planet_mass_neptune);
                planetText3.setText(R.string.planet_grav_neptune);
                planetText4.setText(R.string.planet_size_neptune);
            }
        });

        ImageButton marsButton = findViewById(R.id.ib_mars);
        marsButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View arg0) {
                uiPaneLinearLayout.setBackgroundResource(R.drawable.plasma480);
                planetImageView.setBackgroundResource(R.drawable.ib_mars_normal);
                planetText1.setText(R.string.planet_name_mars);
                planetText2.setText(R.string.planet_mass_mars);
                planetText3.setText(R.string.planet_grav_mars);
                planetText4.setText(R.string.planet_size_mars);
            }
        });
    }
}
