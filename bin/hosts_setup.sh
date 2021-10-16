#!/usr/bin/env bash

hosts=()

if [[ ${#@} -gt 0 ]]; then
    for host in ${@}; do
        if [[ -f ${host}.yml ]]; then
            hosts+=($host)
        fi
    done
else
    echo "Select hosts:"

    for yml in *.yml; do
        host=`echo $yml | sed -e s/\.yml//`

        read -p "Host $host. Are you sure? [y/N] " response

        if [[ $response =~ ^[Yy].* ]]; then
          hosts+=($host)
        fi
    done

    [[ ${#hosts} -gt 0 ]] && echo
fi

if [[ ${#hosts} -gt 0 ]]; then
    echo "Working on:"

    printf "%s\n" ${hosts[@]}

    echo

    read -p "Continue? [y/N] " response

    if [[ $response =~ ^[Yy].* ]]; then
        echo

        for host in "${hosts[@]}"; do
            task host:bootstrap host:setup dotfiles:add -- $host || break
        done
    fi
fi
