<?php

namespace App\Controllers;

use App\Models\MTravel;

class TravelController extends RestfulController
{
    public function create()
    {
        $data = [
            'nama' => $this->request->getVar('nama'),
            'lokasi' => $this->request->getVar('lokasi'),
            'harga' => $this->request->getVar('harga'),
            'deskripsi' => $this->request->getVar('deskripsi'),
            'durasi' => $this->request->getVar('durasi')
        ];
        $model = new MTravel();
        $model->insert($data);
        $travel = $model->find($model->getInsertID());
        return $this->responseHasil(200, true, $travel);
    }

    public function list()
    {
        $model = new MTravel();
        $travel = $model->findAll();
        return $this->responseHasil(200, true, $travel);
    }

    public function detail($id)
    {
        $model = new MTravel();
        $travel = $model->find($id);
        return $this->responseHasil(200, true, $travel);
    }

    public function ubah($id)
    {
        $data = [
            'nama' => $this->request->getVar('nama'),
            'lokasi' => $this->request->getVar('lokasi'),
            'harga' => $this->request->getVar('harga'),
            'deskripsi' => $this->request->getVar('deskripsi'),
            'durasi' => $this->request->getVar('durasi')
        ];
        $model = new MTravel();
        $model->update($id, $data);
        $travel = $model->find($id);
        return $this->responseHasil(200, true, $travel);
    }

    public function hapus($id)
    {
        $model = new MTravel();
        $travel = $model->delete($id);
        return $this->responseHasil(200, true, $travel);
    }
}
