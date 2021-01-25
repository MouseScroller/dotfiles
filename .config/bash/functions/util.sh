#!/bin/bash



function printer_start {
	sudo systemctl start --now cups.service && sudo systemctl start --now cups.socket && sudo systemctl start --now cups.path
}
function printer_stop {
	sudo systemctl stop --now cups.service && sudo systemctl stop --now cups.socket && sudo systemctl stop --now cups.path
}
