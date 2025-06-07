<?php

namespace App\Models;

use CodeIgniter\Model;

class MTravel extends Model
{
    protected $table = 'tours';
    protected $primaryKey = 'id';
    protected $allowedFields = ['nama', 'lokasi', 'harga', 'deskripsi', 'durasi'];
}