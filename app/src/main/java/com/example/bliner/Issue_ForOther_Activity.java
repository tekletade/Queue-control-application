package com.example.bliner;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;

import android.Manifest;
import android.content.DialogInterface;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.util.Log;
import android.util.SparseArray;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.vision.CameraSource;
import com.google.android.gms.vision.Detector;
import com.google.android.gms.vision.barcode.Barcode;
import com.google.android.gms.vision.barcode.BarcodeDetector;

import java.io.IOException;

import okhttp3.MediaType;

public class Issue_ForOther_Activity extends AppCompatActivity{
    public String url= "https://liner12.000webhostapp.com/liner/manage_service.php";
    public String qurl= "https://liner12.000webhostapp.com/liner/manage_queue.php";

    public static final MediaType JSON = MediaType.parse("application/json; charset=utf-8");
    private String sid,cid,coordinator;

    SurfaceView surfaceView;
    TextView detail;
    private BarcodeDetector barcodeDetector;
    private CameraSource cameraSource;
    private static final int REQUEST_CAMERA_PERMISSION = 201;
    Button issue,leave0,shift0;
    String intentData = "";
    boolean isEmail = false;
    LinearLayout layout0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_issue_for_other);
        Bundle extras=getIntent().getExtras();
        sid=extras.getString("sid");
        cid=extras.getString("cid");
        coordinator=extras.getString("coordinator");
        issue=(Button)findViewById(R.id.issue0);
        shift0=(Button)findViewById(R.id.shiftO);
        layout0=(LinearLayout) findViewById(R.id.layout0);
        leave0=(Button)findViewById(R.id.leaveO);
        detail=(TextView)findViewById(R.id.detail);
        initViews();
    }

    private void initViews() {
        surfaceView = findViewById(R.id.surfaceView);
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
                    if (ActivityCompat.checkSelfPermission(Issue_ForOther_Activity.this,
                            android.Manifest.permission.CAMERA) == PackageManager.PERMISSION_GRANTED) {
                        cameraSource.start(surfaceView.getHolder());
                    } else {
                        ActivityCompat.requestPermissions(Issue_ForOther_Activity.this, new
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
                layout0.setEnabled(false);
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
                    detail.post(new Runnable() {
                        @Override
                        public void run() {
                            layout0.setVisibility(View.VISIBLE);
                            intentData = barcodes.valueAt(0).displayValue;
                            detail.setText(intentData);
                            issue.setOnClickListener(new View.OnClickListener() {
                                @Override
                                public void onClick(View v) {
                                    try {
                                        if (intentData.length() > 0) {
                                            service_async asyncs = new service_async(Issue_ForOther_Activity.this
                                                    , null, intentData.toString(), cid, layout0, null, null
                                            );
                                            asyncs.execute("set_queue", sid, intentData.toString(), "Card");

                                        }
                                    } catch (Exception e) {
                                        Log.v("exxxxxx", e.getLocalizedMessage());
                                        AlertDialog.Builder db = new AlertDialog.Builder(getApplicationContext());
                                        db.setTitle("Successful");
                                        db.setMessage(""+e.getLocalizedMessage());
                                        db.setCancelable(false);
                                        db.setPositiveButton("OK", new DialogInterface.OnClickListener() {
                                            public void onClick(DialogInterface dialog, int which) {
                                                dialog.dismiss();
                                            }
                                        });
                                        AlertDialog dialog = db.show();
                                    }
                                }
                            });
                            shift0.setOnClickListener(new View.OnClickListener() {
                                @Override
                                public void onClick(View v) {

                                    if (intentData.length() > 0) {
                                        service_async asyncs=new service_async(Issue_ForOther_Activity.this,null,
                                                intentData.toString(),cid, null, null, null);
                                        asyncs.execute("shiftQ","",intentData.toString(),cid,intentData.toString(),"0");
                                    }
                                }
                            });
                            leave0.setOnClickListener(null);
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

}