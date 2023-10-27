package com.example.bliner;

import android.content.Context;
import android.database.DataSetObserver;
import android.graphics.Color;
import android.view.LayoutInflater;
import android.widget.ImageView;
import android.widget.ListAdapter;
import android.view.View;
import android.view.ViewGroup;

import android.widget.GridView;
import android.widget.TextView;

import java.util.ArrayList;

public class dashboardAdapter implements ListAdapter {
    public ArrayList<company> comps;
    private Context mContext;

    // Constructor
    public dashboardAdapter(Context c, ArrayList<company> comps) {
        mContext = c;
        this.comps=comps;
    }

    @Override
    public void registerDataSetObserver(DataSetObserver observer) {

    }

    @Override
    public void unregisterDataSetObserver(DataSetObserver observer) {

    }

    public int getCount() {
        return comps.size();
    }

    public Object getItem(int position) {
        return comps.get(position);
    }

    public long getItemId(int position) {
        return position;
    }

    @Override
    public boolean hasStableIds() {
        return false;
    }

    // create a new ImageView for each item referenced by the Adapter
    @Override
    public View getView(int position, View convertView1, ViewGroup parent) {
        convertView1=LayoutInflater.from(mContext.getApplicationContext()).inflate(R.layout.dashboardview, parent, false);
       TextView name =convertView1.findViewById(R.id.name);
       ImageView img =convertView1.findViewById(R.id.imageView2);
       img.setImageResource(R.drawable.f3);
       name.setTextSize(20);
       name.setBackgroundColor(Color.CYAN);

        name.setText(comps.get(position).getName());
        return convertView1;
    }

    @Override
    public int getItemViewType(int position) {
        return position;
    }

    @Override
    public int getViewTypeCount() {
        return comps.size();
    }

    @Override
    public boolean isEmpty() {
        return false;
    }

    // Keep all Images in array


    @Override
    public boolean areAllItemsEnabled() {
        return true;
    }

    @Override
    public boolean isEnabled(int position) {
        return true;
    }


}