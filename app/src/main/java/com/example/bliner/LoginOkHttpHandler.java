package com.example.bliner;

import android.os.AsyncTask;
import android.util.Log;
import android.widget.TextView;

import androidx.appcompat.app.ActionBar;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

public class LoginOkHttpHandler extends AsyncTask {

    OkHttpClient client = new OkHttpClient();
    private TextView txtString;

    @Override
    protected String doInBackground(Object...params) {

        Request.Builder builder = new Request.Builder();
        builder.url(params[0].toString());
        Request request = builder.build();

        try {
            Response response = client.newCall(request).execute();
            return response.body().string();
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }


    protected void onPostExecute(String s) {
        super.onPostExecute(s);
        txtString.setText(s);
    }
}