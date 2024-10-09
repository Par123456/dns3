#!/bin/bash

# رمز عبور
PASSWORD="No1"

# درخواست رمز عبور از کاربر
read -sp "Enter password: " input_password
echo

# بررسی رمز عبور
if [ "$input_password" != "$PASSWORD" ]; then
    echo "Incorrect password"
    exit 1
fi

# کاربران و مدیران
declare -A users
users["parsa"]="No11386"
users["kelavs"]="Matin1383"
users["Ali24be"]="Ali24beuser"
users["farzin"]="Farzin55"

declare -A admins
admins["no1"]="no1ad"
admins["kurdone"]="kurdonead"
admins["kelavs"]="kelavsad"

# درخواست یوزرنیم و پسورد از کاربر
read -p "Enter username: " username
read -sp "Enter password: " password
echo

# بررسی یوزرنیم و پسورد
if [ "${admins[$username]}" == "$password" ]; then
    echo "Admin login successful"
    # کدهای مربوط به پنل ادمین
elif [ "${users[$username]}" == "$password" ]; then
    echo "User login successful"
    # کدهای مربوط به پنل کاربر
else
    echo "Incorrect username or password"
    exit 1
fi

# توابع تولید IP و DDNS
generate_random_ip() {
    echo "$((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256))"
}

generate_random_ddns() {
    local chars="abcdefghijklmnopqrstuvwxyz0123456789"
    local ddns=""
    for i in {1..10}; do
        ddns+="${chars:RANDOM%${#chars}:1}"
    done
    echo "$ddns.no1xkurdxkelavs.$1"
}

generate_random_ipv6() {
    local chars="0123456789abcdef"
    local ipv6="$1$2:"
    for i in {1..7}; do
        ipv6+="${chars:RANDOM%${#chars}:1}${chars:RANDOM%${#chars}:1}${chars:RANDOM%${#chars}:1}${chars:RANDOM%${#chars}:1}:"
    done
    echo "${ipv6%:}"
}

increment_ipv6() {
    local parts=(${1//:/ })
    local last_part=$((0x${parts[-1]} + 1))
    parts[-1]=$(printf "%04x" $last_part)
    echo "${parts[*]}"
}

# لیست کشورها
declare -A countries
countries=(
    ["1"]="IR"
    ["2"]="DE"
    ["3"]="TR"
    ["4"]="UK"
    ["5"]="AE"
    ["6"]="CH"
    ["7"]="US"
    ["8"]="CA"
    ["9"]="BH"
    ["10"]="SA"
    ["11"]="AL"
    ["12"]="FI"
    ["13"]="RU"
    ["14"]="FR"
    ["15"]="NL"
    ["16"]="DZ"
    ["17"]="EG"
    ["18"]="BG"
    ["19"]="TJ"
)

# درخواست شماره کشور از کاربر
echo "Select a country by number:"
for key in "${!countries[@]}"; do
    echo "$key) ${countries[$key]}"
done

read -p "Enter country number: " country_number

# بررسی شماره کشور
if [ -z "${countries[$country_number]}" ]; then
    echo "Invalid country number"
    exit 1
fi

country_code="${countries[$country_number]}"
endip=$(generate_random_ip)
ddns=$(generate_random_ddns "$country_code")
ipv6_1=$(generate_random_ipv6 "$country_code" "$country_number")
ipv6_2=$(increment_ipv6 "$ipv6_1")

echo "Country: $country_code"
echo "IPv4: $endip"
echo "APN: $ddns"
echo "IPv6 Address 1: $ipv6_1"
echo "IPv6 Address 2: $ipv6_2"
