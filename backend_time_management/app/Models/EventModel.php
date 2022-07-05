<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class EventModel extends Model
{
    protected $fillable = [
        'event',
        'date',
        'time',
    ];
    use HasFactory;
}
