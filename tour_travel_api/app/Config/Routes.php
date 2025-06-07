<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */
$routes->get('/', 'Home::index');
$routes->post('/registrasi', 'RegisterController::registrasi');
$routes->post('/login', 'LoginController::login');
$routes->post('/logout', 'LogoutController::logout');
$routes->group('travel', function ($routes) {
    $routes->post('/', 'TravelController::create');
    $routes->get('/', 'TravelController::list');
    $routes->get('(:segment)', 'TravelController::detail/$1');
    $routes->put('(:segment)', 'TravelController::ubah/$1');
    $routes->delete('(:segment)', 'TravelController::hapus/$1');
});
