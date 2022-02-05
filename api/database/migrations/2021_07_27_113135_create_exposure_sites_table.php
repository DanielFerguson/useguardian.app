<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateExposureSitesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('exposure_sites', function (Blueprint $table) {
            $table->id();

            $table->string('country');
            $table->string('state');
            $table->string('title');
            $table->dateTime('datetime', 0);
            $table->float('lat', 16, 13);
            $table->float('lng', 16, 13);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('exposure_sites');
    }
}
