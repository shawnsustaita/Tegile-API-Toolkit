#!/bin/bash


# ENVIRONMENT VARIABLES

Auth_TOKEN=$( echo -n USERNAME:PASSWORD | base64 )
CURL="curl -s -q -k -X POST -H Content-Type:application/json"


### GENERIC LEVEL FUNCTIONS

tegile_list_snapshots() {
	[ $# -eq 5 ] || {
		echo "Function usage: tegile_list_snapshots system pool project share snapshot_name_regex"
		return 128
	}
	
	$CURL -H "Authorization:Basic ${Auth_TOKEN}" -d "[\"${2}/Local/${3}/${4}\", \"${5}\"]" https://${1}/zebi/api/v1/listSnapshots
}


### SHARE LEVEL FUNCTIONS

tegile_list_shares() {
    [ $# -eq 3 ] || {
        echo "Function usage: tegile_list_shares system pool project"
        return 128
    }

	$CURL -H "Authorization:Basic ${Auth_TOKEN}" -d "[\"${2}\", \"${3}\", true]" https://${1}/zebi/api/v1/listShares
}

tegile_delete_share() {
    [ $# -eq 4 ] || {
        echo "Function usage: tegile_delete_share system pool project share_name"
        return 128
    }

	$CURL -H "Authorization:Basic ${Auth_TOKEN}" -d "[\"${2}/Local/${3}/${4}\", false, false]" https://${1}/zebi/api/v1/deleteShare
}

tegile_create_share_snapshot() {
    [ $# -eq 5 ] || {
        echo "Function usage: tegile_create_share_snapshot system pool project share snapshot_name"
        return 128
    }

	$CURL -H "Authorization:Basic ${Auth_TOKEN}" -d "[{\"poolName\": \"${2}\", \"projectName\": \"${3}\", \"name\": \"${4}\", \"datasetPath\": \"${2}/Local/${3}/${4}\", \"local\": true}, \"${5}\", true]" https://${1}/zebi/api/v1/createShareSnapshot
}

tegile_delete_share_snapshot() {
    [ $# -eq 5 ] || {
        echo "Function usage: tegile_delete_share_snapshot system pool project share snapshot_name"
        return 128
    }

	$CURL -H "Authorization:Basic ${Auth_TOKEN}" -d "[\"${2}/Local/${3}/${4}@${5}\", false]" https://${1}/zebi/api/v1/deleteShareSnapshot
}

tegile_create_share_clone() {
    [ $# -eq 6 ] || {
        echo "Function usage: tegile_create_share_clone system pool project share snapshot_name clone_name"
        return 128
    }

	$CURL -H "Authorization:Basic ${Auth_TOKEN}" -d "[\"${2}/Local/${3}/${4}@${5}\", \"${6}\", true]" https://${1}/zebi/api/v1/cloneShareSnapshot
}


