<?php

namespace App\Observers;

use Carbon\Carbon;
use App\Models\ExposureSite;
use Illuminate\Support\Facades\Cache;
use Kreait\Firebase\Messaging\CloudMessage;
use Lcobucci\JWT\Exception;

class ExposureSiteObserver
{
    /**
     * Handle the ExposureSite "created" event.
     *
     * @param \App\Models\ExposureSite $exposureSite
     * @return void
     */
    public function created()
    {
        Cache::flush('exposure-sites');

        Cache::rememberForever('exposure-sites', ExposureSite::whereBetween('datetime', [
            Carbon::now()->subdays(30),
            Carbon::now()
        ])->get());

        //Trigger FCM message
        try {
            $topic = 'guardian-exposure';
            $messaging = app('firebase.messaging');
            $message = CloudMessage::fromArray([
                'topic' => $topic,
                'notification' => ["title" => "Test message notification", "body" => "", "image" => ""], // optional
                'data' => [], // optional
            ]);
            $messaging->send($message);
        } catch (Exception $e) {
            dd($e);
        }
    }
}
