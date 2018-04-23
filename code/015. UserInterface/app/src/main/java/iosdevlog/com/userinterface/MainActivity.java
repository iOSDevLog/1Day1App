package iosdevlog.com.userinterface;

import android.app.Activity;
import android.content.Intent;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.MediaController;
import android.widget.VideoView;

public class MainActivity extends Activity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        VideoView introVideo = findViewById(R.id.videoView);
        Uri introVideoUri = Uri.parse("android.resource://" + getPackageName() + "/" + R.raw.intro);
        introVideo.setVideoURI(introVideoUri);
        MediaController introVideoMediaController = new MediaController(this);
        introVideoMediaController.setAnchorView(introVideo);
        introVideo.setMediaController(introVideoMediaController);
        introVideo.setOnPreparedListener(new MediaPlayer.OnPreparedListener() {
            @Override
            public void onPrepared(MediaPlayer arg0) {
                arg0.setLooping(false);
            }
        });
        introVideo.start();
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.linear_layout:
                Intent intent_ll = new Intent(this, LinearActivity.class);
                this.startActivity(intent_ll);
                break;
            case R.id.relative_layout:
                Intent intent_rl = new Intent(this, RelativeActivity.class);
                this.startActivity(intent_rl);
                break;
            case R.id.grid_layout:
                Intent intent_gl = new Intent(this, GridActivity.class);
                this.startActivity(intent_gl);
                break;
            case R.id.drawer_layout:
                Intent intent_dl = new Intent(this, DrawerActivity.class);
                this.startActivity(intent_dl);
                break;
            case R.id.sliding_layout:
                Intent intent_spl = new Intent(this, SlidingPaneActivity.class);
                this.startActivity(intent_spl);
                break;
            case R.id.paging_layout:
                Intent intent_vpl = new Intent(this, ViewPagingActivity.class);
                this.startActivity(intent_vpl);
                break;
            case R.id.analog_clock_layout:
                Intent intent_acl = new Intent(this, AnalogClockActivity.class);
                this.startActivity(intent_acl);
                break;
        }
        return true;
    }
}