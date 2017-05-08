#!/bin/bash

rails spec && git push origin master && git push heroku master
