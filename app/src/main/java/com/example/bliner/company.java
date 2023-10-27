package com.example.bliner;

import com.google.gson.annotations.SerializedName;

public class company {
String cid,name,branchname,location;
String isbranch;

    public company(String cid, String name, String branchname, String location, String isbranch) {
        this.cid = cid;
        this.name = name;
        this.branchname = branchname;
        this.location = location;
        this.isbranch = isbranch;
    }

    public String getCid() {
        return cid;
    }

    public void setCid(String cid) {
        this.cid = cid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBranchname() {
        return branchname;
    }

    public void setBranchname(String branchname) {
        this.branchname = branchname;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String isIsbranch() {
        return isbranch;
    }

    public void setIsbranch(String isbranch) {
        this.isbranch = isbranch;
    }
}
