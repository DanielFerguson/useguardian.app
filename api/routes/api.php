<?php

use App\Models\ExposureSite;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Route;
use Kreait\Firebase\Messaging\CloudMessage;
use Lcobucci\JWT\Exception;

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

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::get('/latest', function () {
    // ExposureSite::latest()->first()
    return 'test';
    // return response('hello', 200)->header('Content-Type', 'application/json');
});

Route::get('/exposure-sites', function () {
    Cache::flush('exposure-sites');
    return response(
        Cache::rememberForever('exposure-sites', function () {
            return ExposureSite::whereBetween('datetime', [
                Carbon::now()->subdays(30),
                Carbon::now()
            ])->get();
        }),
        200
    )->header('Content-Type', 'application/json');
});

Route::get('/send-fcm-message', function (Request $request) {
    try {
        $lat = $request->get("lat");
        $lng = $request->get("lng");
        $lastExposureSite = ExposureSite::select('id')->orderBy('id', 'desc')->first();
        if ($lastExposureSite) {
            $exposureSite = new ExposureSite();
            $exposureSite->id = $lastExposureSite->id + 1;
            $exposureSite->country = "au";
            $exposureSite->state = "vic";
            $exposureSite->title = "temp location";
            $exposureSite->datetime = Carbon::now()->toDateTimeString();
            $exposureSite->lat = $lat;
            $exposureSite->lng = $lng;
            $exposureSite->url = "https://www.coronavirus.vic.gov.au/exposure-site";
            $exposureSite->save();
        }

        $topic = 'guardian-exposure';
        $messaging = app('firebase.messaging');
        $message = CloudMessage::fromArray([
            'topic' => $topic,
            //'notification' => ["title"=>"Demo test message notification", "body"=> "","image"=> ""], // optional
            'data' => ["title" => "Demo test message notification", "body" => "", "image" => ""], // optional
        ]);
        $messaging->send($message);
        dd($messaging);
    } catch (Exception $e) {
        dd($e);
    }
});
