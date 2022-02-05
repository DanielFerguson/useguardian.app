<?php

namespace App\Jobs;

use App\Models\ExposureSite;
use DateTime;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Http;

class FetchVicExposureSites implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public function handle()
    {
        $endpoint = "https://www.coronavirus.vic.gov.au/sdp-ckan?resource_id=afb52611-6061-4a2b-9110-74c920bede77&limit=10000";

        $response = Http::get($endpoint)->object();

        foreach ($response->result->records as $site) {

            $datetime = DateTime::createFromFormat('d/m/Y H:i:s', $site->Exposure_date . ' ' . $site->Exposure_time_start_24);

            if (!ExposureSite::where([
                'country' => 'au',
                'state' => 'vic',
                'title' => $site->Site_title,
                'datetime' => $datetime
            ])->exists()) {

                if (
                    $site->Site_title &&
                    $site->Site_streetaddress &&
                    $site->Suburb
                ) {
                    $address = urlencode("{$site->Site_title} {$site->Site_streetaddress}, {$site->Suburb}, VIC, {$site->Site_postcode}, AU");
                } else {
                    $address = urlencode("{$site->Site_title}, VIC, AU");
                }

                $location = Http::post("https://maps.googleapis.com/maps/api/geocode/json?address={$address}&key=" . env('GOOGLE_CLOUD_KEY'))->object();

                try {
                    $location = $location->results[0];
                } catch (\ErrorException $th) {
                    continue;
                }

                ExposureSite::create([
                    'country' => 'au',
                    'url' => 'https://www.coronavirus.vic.gov.au/exposure-site',
                    'state' => 'vic',
                    'title' => $site->Site_title,
                    'datetime' => $datetime,
                    'lat' => $location->geometry->location->lat,
                    'lng' => $location->geometry->location->lng,
                ]);
            }
        }
    }
}
