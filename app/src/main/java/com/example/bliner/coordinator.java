package com.example.bliner;

public class coordinator {
String name,sid,coordinator,state,nextwaiters,totalwaiters;

    public coordinator(String name, String sid, String coordinator, String state, String nextwaiters, String totalwaiters) {
        this.name = name;
        this.sid = sid;
        this.coordinator = coordinator;
        this.state = state;
        this.nextwaiters = nextwaiters;
        this.totalwaiters = totalwaiters;
    }

    public String getNextwaiters() {
        return nextwaiters;
    }

    public void setNextwaiters(String nextwaiters) {
        this.nextwaiters = nextwaiters;
    }

    public String getTotalwaiters() {
        return totalwaiters;
    }

    public void setTotalwaiters(String totalwaiters) {
        this.totalwaiters = totalwaiters;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSid() {
        return sid;
    }

    public void setSid(String sid) {
        this.sid = sid;
    }

    public String getCoordinator() {
        return coordinator;
    }

    public void setCoordinator(String coordinator) {
        this.coordinator = coordinator;
    }
}
