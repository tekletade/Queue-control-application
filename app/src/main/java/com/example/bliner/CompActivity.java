package com.example.bliner;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.widget.TextView;

public class CompActivity extends AppCompatActivity {
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_comp);

        // Get intent data
        Intent i = getIntent();

        // Selected image id
        int position = i.getExtras().getInt("id");
        dashboardAdapter imageAdapter = new dashboardAdapter(this,null);

        TextView imageView = (TextView) findViewById(R.id.SingleView);
        imageView.setText(imageAdapter.comps.get(position).getCid());
    }
}