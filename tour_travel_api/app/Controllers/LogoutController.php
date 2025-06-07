<?php

namespace App\Controllers;

use App\Models\MLogin;

class LogoutController extends RestfulController
{
    public function logout()
    {
        $auth_key = $this->request->getHeaderLine('Authorization');

        if (empty($auth_key)) {
            return $this->responseHasil(400, false, "Token tidak ditemukan");
        }

        $model = new MLogin();
        $login = $model->where(['auth_key' => $auth_key])->first();

        if (!$login) {
            return $this->responseHasil(400, false, "Token tidak valid");
        }

        $model->delete($login['id']);

        return $this->responseHasil(200, true, "Logout berhasil");
    }
}
