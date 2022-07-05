<?php

use App\Http\Controllers\AuthenticationController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\EventController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

// Public route
Route::post("/register", [AuthenticationController::class, "register"]);
Route::post("/login", [AuthenticationController::class, "login"]);
Route::get("/getEvent", [EventController::class, "getEvent"]);
Route::post("/createEvent", [EventController::class, "createEvent"]);

// Private route
Route::group(['middleware'=>["auth:sanctum"]], function(){
    // For event
    // Route::post("/event", [EventController::class, "createEvent"]);
    // Route::get("/getEvent", [EventController::class, "getEvent"]);
});

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
