<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ExposureSite extends Model
{
    use HasFactory;

    public $timestamps = false;

    protected $fillable = [
        'country',
        'state',
        'title',
        'url',
        'datetime',
        'lat',
        'lng'
    ];

    public function latest()
    {
        return $this->orderBy('datetime', 'desc');
    }
}
