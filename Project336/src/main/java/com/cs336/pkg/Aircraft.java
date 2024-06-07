package com.cs336.pkg;

import java.util.Set;

public class Aircraft {
    private String aircraftId;
    private String airlineId;
    private int numSeats;
    private Set<String> operateDays;

    public Aircraft(String aircraftId, String airlineId, int numSeats, Set<String> operateDays) {
        this.aircraftId = aircraftId;
        this.airlineId = airlineId;
        this.numSeats = numSeats;
        this.operateDays = operateDays;
    }

    public String getAircraftId() {
        return aircraftId;
    }

    public void setAircraftId(String aircraftId) {
        this.aircraftId = aircraftId;
    }

    public String getAirlineId() {
        return airlineId;
    }

    public void setAirlineId(String airlineId) {
        this.airlineId = airlineId;
    }

    public int getNumSeats() {
        return numSeats;
    }

    public void setNumSeats(int numSeats) {
        this.numSeats = numSeats;
    }

    public Set<String> getOperateDays() {
        return operateDays;
    }

    public void setOperateDays(Set<String> operateDays) {
        this.operateDays = operateDays;
    }
}
