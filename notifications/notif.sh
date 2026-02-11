#!/bin/sh
Project="comancheo-cv"
gcloud config set project $Project
Bearer=$(gcloud auth print-access-token)
FCMToken="veverky"
if [ ! -z "$1" -a "$1" != " " ]; then
    FCMToken=$1
fi
read -p "Press enter to send notification to $Project with token $Bearer"
curl --location --request POST "https://fcm.googleapis.com/v1/projects/$Project/messages:send" \
--header "Authorization: Bearer $Bearer" \
--header 'Content-Type: application/json' \
--data-raw '{
    "message": {
        "token": "'$FCMToken'",
        "notification" : {
            "title" : "Preventivní prohlídka",
            "body" : "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer eleifend non purus facilisis pharetra. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Morbi eget viverra metus, in bibendum sem. Morbi rhoncus cursus purus vitae suscipit. Etiam auctor ultrices lacus, vel mollis augue. Nunc non ex dolor. Praesent ornare iaculis nunc, scelerisque consequat arcu venenatis sed. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Aenean elementum sem finibus erat pharetra, ac lacinia purus suscipit. Proin sapien felis, accumsan tristique molestie ac, vehicula ut magna. Suspendisse mauris lorem, convallis eget egestas id, luctus in elit. Nam velit lorem, aliquam in lacinia at, rutrum sit amet ligula. Etiam nec enim sapien. Nunc tincidunt congue purus. Vestibulum non tincidunt justo. Duis velit dui, tincidunt id nibh at, euismod congue sem. Aliquam varius dictum dolor vel porta. Praesent sit amet felis suscipit, interdum sem et, porta nulla. Nulla eu arcu eu arcu finibus vestibulum eget non elit. Integer pulvinar sodales eros et hendrerit. Donec et posuere urna. Nulla euismod tempor odio, at cursus quam fringilla eu. Fusce aliquam leo nec rhoncus ullamcorper. Mauris efficitur vulputate magna, at lacinia sem imperdiet nec. Phasellus vulputate libero tempus imperdiet mollis. Proin pretium consectetur lacus, a ultrices justo fringilla id. Mauris neque turpis, tempus sit amet faucibus ornare, pellentesque suscipit metus. Pellentesque tincidunt interdum purus. Fusce tempus commodo pulvinar. Suspendisse sed odio vel nisi consectetur consectetur. Sed nisi purus, imperdiet nec placerat et, euismod non nisl. Maecenas eu eros sit amet erat placerat pellentesque vel malesuada nunc. Phasellus sed dolor elementum, pellentesque risus eu, aliquet neque. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nam elementum tellus at felis tincidunt molestie. Maecenas sit amet lacus non tortor porta commodo. In euismod aliquam varius. Maecenas accumsan lacus ac bibendum sollicitudin. Morbi lacus elit, luctus non neque ut, convallis pretium velit. Nullam consequat egestas leo vel bibendum.",
        },
    }
}'
read -p "Press enter to continue"

