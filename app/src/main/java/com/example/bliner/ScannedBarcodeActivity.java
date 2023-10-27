package com.example.bliner;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;

import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;
import android.Manifest;
import android.util.SparseArray;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.vision.CameraSource;
import com.google.android.gms.vision.Detector;
import com.google.android.gms.vision.barcode.Barcode;
import com.google.android.gms.vision.barcode.BarcodeDetector;

import org.json.JSONObject;

import java.io.IOException;

import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class ScannedBarcodeActivity extends AppCompatActivity implements View.OnClickListener {
    public String url= "https://liner12.000webhostapp.com/liner/manage_service.php";
    public String qurl= "https://liner12.000webhostapp.com/liner/manage_queue.php";

    public static final MediaType JSON = MediaType.parse("application/json; charset=utf-8");
    private String sid,coordinator;

    SurfaceView surfaceView;
    TextView txtBarcodeValue;
    private BarcodeDetector barcodeDetector;
    private CameraSource cameraSource;
    private static final int REQUEST_CAMERA_PERMISSION = 201;
    Button btnAction;
    String intentData = "";
    boolean isEmail = false;
EditText rangeval;
Button rangebtn;
String sname,totalw,nextw;
    private TextView svcname,total,nextwaiter;
    Button issueforothers;
    private String gcid;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_scanned_barcode);
        Bundle extras=getIntent().getExtras();
        sid=extras.getString("sid");
        gcid=extras.getString("gcid");
        sname=extras.getString("sname");
        totalw=extras.getString("total");
        nextw=extras.getString("nextw");
        coordinator=extras.getString("coordinator");
        rangebtn=(Button)findViewById(R.id.rangebtn);
        svcname=(TextView)findViewById(R.id.txtsvcname);
        total=(TextView)findViewById(R.id.total);
        nextwaiter=(TextView)findViewById(R.id.nextwaiter);
        issueforothers=(Button)findViewById(R.id.btnAction);
        rangebtn=(Button)findViewById(R.id.rangebtn);
        rangeval=(EditText)findViewById(R.id.rangeval);
        svcname.setText(sname);
        total.setText("Total: "+totalw);
        nextwaiter.setText("Next: "+nextw);
        rangebtn.setOnClickListener(this);
        try {
            initViews();
        }catch (Exception ex){
            Log.v("444411111",ex.getLocalizedMessage());
            ex.printStackTrace();;
        }
    }

    private void initViews() {
        txtBarcodeValue = findViewById(R.id.txtBarcodeValue);
        surfaceView = findViewById(R.id.surfaceView);
        btnAction = findViewById(R.id.btnAction);
btnAction.setOnClickListener(new View.OnClickListener() {
    @Override
    public void onClick(View view) {
        Intent in = new Intent(getApplicationContext(), Issue_ForOther_Activity.class);
        Toast.makeText(ScannedBarcodeActivity.this, "Not yet", Toast.LENGTH_SHORT).show();
        in.putExtra("sid", sid);
        in.putExtra("cid", gcid);
        in.putExtra("coordinator", coordinator);
        in.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
      //  startActivity(in);
    }
});
    }

    private void initialiseDetectorsAndSources() {

        Toast.makeText(getApplicationContext(), "Barcode scanner started", Toast.LENGTH_SHORT).show();

        barcodeDetector = new BarcodeDetector.Builder(this)
                .setBarcodeFormats(Barcode.ALL_FORMATS)
                .build();

        cameraSource = new CameraSource.Builder(this, barcodeDetector)
                .setRequestedPreviewSize(1920, 1080)
                .setAutoFocusEnabled(true) //you should add this feature
                .build();

        surfaceView.getHolder().addCallback(new SurfaceHolder.Callback() {
            @Override
            public void surfaceCreated(SurfaceHolder holder) {
                try {
                    if (ActivityCompat.checkSelfPermission(ScannedBarcodeActivity.this,
                            Manifest.permission.CAMERA) == PackageManager.PERMISSION_GRANTED) {
                        cameraSource.start(surfaceView.getHolder());
                    } else {
                        ActivityCompat.requestPermissions(ScannedBarcodeActivity.this, new
                                String[]{Manifest.permission.CAMERA}, REQUEST_CAMERA_PERMISSION);
                    }

                } catch (IOException e) {
                    e.printStackTrace();
                }


            }

            @Override
            public void surfaceChanged(SurfaceHolder holder, int format, int width, int height) {
            }

            @Override
            public void surfaceDestroyed(SurfaceHolder holder) {
                cameraSource.stop();
            }
        });


        barcodeDetector.setProcessor(new Detector.Processor<Barcode>() {
            @Override
            public void release() {
                Toast.makeText(getApplicationContext(), "To prevent memory leaks barcode scanner has been stopped", Toast.LENGTH_SHORT).show();
            }

            @Override
            public void receiveDetections(Detector.Detections<Barcode> detections) {
                final SparseArray<Barcode> barcodes = detections.getDetectedItems();
                if (barcodes.size() != 0) {
                    txtBarcodeValue.post(new Runnable() {
                        @Override
                        public void run() {
                            try {
                                btnAction.setText("Issue for others");
                                intentData = barcodes.valueAt(0).displayValue;
                                coordinator_async oassync = new coordinator_async(ScannedBarcodeActivity.this, null, coordinator, sid);
                                oassync.execute("callforqueue", intentData.toString(), sid, coordinator);
                                txtBarcodeValue.setText(intentData);
                            }catch (Exception e){
                                Log.v("exxxxxx",e.getLocalizedMessage());
                                e.printStackTrace();
                            }
                        }
                    });

                }
            }
        });
    }




    @Override
    protected void onPause() {
        super.onPause();
        cameraSource.release();
    }

    @Override
    protected void onResume() {
        super.onResume();
        initialiseDetectorsAndSources();
    }

    @Override
    public void onClick(View view) {
        coordinator_async oassync=new coordinator_async(this, null, coordinator,sid);
        oassync.execute("callfornext",sid,rangeval.getText().toString());
    }
}