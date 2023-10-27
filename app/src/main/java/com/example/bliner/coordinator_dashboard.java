package com.example.bliner;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.RecyclerView;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.Toast;

import java.util.List;

public class coordinator_dashboard extends AppCompatActivity implements View.OnClickListener {

    private ListView colist;
    private Button rangbtn;
    private EditText rang;
    private String sid;
    private String coordinator;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_coordinator_dashboard);
        colist=(ListView) findViewById(R.id.colist);
        Bundle extras=getIntent().getExtras();
        sid=extras.getString("sid");
        coordinator=extras.getString("coordinator");
        rangbtn=(Button)findViewById(R.id.rangecall);
        rang=(EditText)findViewById(R.id.range);
        rangbtn.setOnClickListener(this);
        try {
            coordinator_async oassync=new coordinator_async(this,colist,coordinator,sid);
            oassync.execute("service_q_detail",sid);
            //postRequest(url,postBody);
        } catch (Exception e) {
            Toast.makeText(this,e.getLocalizedMessage(),Toast.LENGTH_SHORT).show();
        }
    }

    @Override
    public void onClick(View v) {
        try {
            coordinator_async oassync=new coordinator_async(this,colist,null,sid);
            oassync.execute("callfornext",rang.getText().toString(),sid);

            //postRequest(url,postBody);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}