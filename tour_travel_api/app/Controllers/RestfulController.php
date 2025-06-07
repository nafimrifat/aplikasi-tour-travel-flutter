<?php

namespace App\Controllers;

use CodeIgniter\RESTful\ResourceController;

class RestfulController extends ResourceController
{

    protected $format = 'json';

    protected function responseHasil($code, $status, $data)
    {
        return $this->respond([
            'code' => $code,
            'status' => $status,
            'data' => $data
        ]);
    }

    public function someMethod()
    {
        // Tambahkan header CORS di sini
        header("Access-Control-Allow-Origin: *");
        header("Access-Control-Allow-Methods: GET, POST, OPTIONS, PUT, DELETE");
        header("Access-Control-Allow-Headers: Content-Type, Authorization");

        // Kode lainnya
        return $this->respond(['status' => 'success']);
    }
}