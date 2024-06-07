package com.cs336.pkg;

public class Flight {
    private int flightNum;
    private String airlineId;
    private String aircraftId;
    private String departureTime;
    private String arrivalTime;
    private String airportIdFrom;
    private String airportIdTo;
    private String domesticOrInternational;
    
    public Flight(int flightNum, String airlineId, String aircraftId, String departureTime, String arrivalTime, String airportIdFrom, String airportIdTo, String domesticOrInternational) {
        this.flightNum = flightNum;
        this.airlineId = airlineId;
        this.aircraftId = aircraftId;
        this.departureTime = departureTime; // Variable name: departure_time. Is a datetime variable
        this.arrivalTime = arrivalTime; // Variable name: arrival_time. Is a datetime variable
        this.airportIdFrom = airportIdFrom;
        this.airportIdTo = airportIdTo;
        this.domesticOrInternational = domesticOrInternational;
    }

    public int getFlightNum() {
        return flightNum;
    }
    
    public void setFlightNum(int flightNum) {
        this.flightNum = flightNum;
    }

    public String getAirlineId() {
        return airlineId;
    }
    public void setAirlineId(String airlineId) {
        this.airlineId = airlineId;
    }

    public String getAircraftId() {
        return aircraftId;
    }
    
    public void setAircraftId(String aircraftId) {
        this.aircraftId = aircraftId;
    }

    public String getDepartureTime() {
        return departureTime;
    }
    
    public void setDepartureTime(String departureTime) {
        this.departureTime = departureTime;
    }

    public String getArrivalTime() {
        return arrivalTime;
    }
    
    public void setArrivalTime(String arrivalTime) {
        this.arrivalTime = arrivalTime;
    }

    public String getAirportIdFrom() {
        return airportIdFrom;
    }
    
    public String getAirportIdTo() {
        return airportIdTo;
    }
    
    public void setAirportIdFrom(String airportIdFrom) {
        this.airportIdFrom = airportIdFrom;
    }
    
    public void setAirportIdTo(String airportIdTo) {
        this.airportIdTo = airportIdTo;
    }

    public String getDomesticOrInternational() {
        return domesticOrInternational;
    }
    
    public void setDomesticOrInternational(String domesticOrInternational) {
        this.domesticOrInternational = domesticOrInternational;
    }
}
