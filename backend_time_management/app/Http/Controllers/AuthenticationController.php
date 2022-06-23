<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class AuthenticationController extends Controller
{
    public function register(Request $request){
        // Validating the user data.        
        $fields = $request -> validate([
            "name" => "required|string",
            "email" => "required|string",
            "gender" => "required|string",
            "date_of_birth" => "required|string",
            "password" => "required|string|confirmed",
        ]);

        // Creating the user.
        $user = User::create([
            "name" => $fields["name"],
            "email" => $fields["email"],
            "gender" => $fields["gender"],
            "date_of_birth" => $fields["date_of_birth"],
            "password" => bcrypt($fields["password"]),
        ]);

        // Creating the token for the user.
        $token = $user->createToken("token")->plainTextToken;

        if ($user->save()){
            return response()->json([
                "success" => true,
                "token" => $token,
            ]);
        }else{
            return response()-> json([
                "success" => false,
            ]);
        }
    }

    public function login(Request $request){
        $fields = $request->validate([
            "email" => "required|String",
            "password" => "required|String",
        ]);

        $user = User::where("email", $fields["email"])->first();

        // Checking password
        if (!$user || !Hash::check($fields["password"], $user->password)){
            return response([
                "message" => "Bad Crenditials",
            ], 401);
        }


        // Creating token when login
        $token = $user->createToken("apptoken")->plainTextToken;

        $response = [
            "user" => $user,
            "token" => $token,
        ];


        return $response;
    }

}
