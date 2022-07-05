<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\EventModel;

class EventController extends Controller
{
    // To get the value from database and send to api
    public function getEvent(){
        return EventModel::all();
    }

    // Creating event 
    public function createEvent(Request $request){
        $request->validate([
            'event' => 'required|string',
            'date' => 'required|string',
            'time' => 'required|string',
        ]);

        return EventModel::create($request->all());
    }

    // update
    public function updateEvent(Request $request, $id){
        $event = EventModel::find($id);
        $event->update($request->all());
        return $event;
    }
    // delete


    
}
