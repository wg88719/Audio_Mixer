webtalk_init -webtalk_dir /home/harsha/work/Zynq/workspace/Audio_Mixer_1.1/Audio_Mixer_1.1.sdk/webtalk
webtalk_register_client -client project
webtalk_add_data -client project -key date_generated -value "Sun May 15 03:41:01 2016" -context "software_version_and_target_device"
webtalk_add_data -client project -key product_version -value "SDK v2015.4" -context "software_version_and_target_device"
webtalk_add_data -client project -key build_version -value "2015.4" -context "software_version_and_target_device"
webtalk_add_data -client project -key os_platform -value "amd64" -context "software_version_and_target_device"
webtalk_add_data -client project -key registration_id -value "" -context "software_version_and_target_device"
webtalk_add_data -client project -key tool_flow -value "SDK" -context "software_version_and_target_device"
webtalk_add_data -client project -key beta -value "false" -context "software_version_and_target_device"
webtalk_add_data -client project -key route_design -value "NA" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_family -value "NA" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_device -value "NA" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_package -value "NA" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_speed -value "NA" -context "software_version_and_target_device"
webtalk_add_data -client project -key random_id -value "v1uqbmr3tbi1r9v7r9at16ghs" -context "software_version_and_target_device"
webtalk_add_data -client project -key project_id -value "2015.4_23" -context "software_version_and_target_device"
webtalk_add_data -client project -key project_iteration -value "23" -context "software_version_and_target_device"
webtalk_add_data -client project -key os_name -value "" -context "user_environment"
webtalk_add_data -client project -key os_release -value "" -context "user_environment"
webtalk_add_data -client project -key cpu_name -value "" -context "user_environment"
webtalk_add_data -client project -key cpu_speed -value "" -context "user_environment"
webtalk_add_data -client project -key total_processors -value "" -context "user_environment"
webtalk_add_data -client project -key system_ram -value "" -context "user_environment"
webtalk_register_client -client sdk
webtalk_add_data -client sdk -key uid -value "1463272588000" -context "sdk\\\\bsp/1463272588000"
webtalk_add_data -client sdk -key hwid -value "1463242060000" -context "sdk\\\\bsp/1463272588000"
webtalk_add_data -client sdk -key os -value "standalone" -context "sdk\\\\bsp/1463272588000"
webtalk_add_data -client sdk -key apptemplate -value "zynq_fsbl" -context "sdk\\\\bsp/1463272588000"
webtalk_add_data -client sdk -key uid -value "1463272612000" -context "sdk\\\\application/1463272612000"
webtalk_add_data -client sdk -key hwid -value "1463242060000" -context "sdk\\\\application/1463272612000"
webtalk_add_data -client sdk -key bspid -value "1463272588000" -context "sdk\\\\application/1463272612000"
webtalk_add_data -client sdk -key newbsp -value "true" -context "sdk\\\\application/1463272612000"
webtalk_add_data -client sdk -key os -value "standalone" -context "sdk\\\\application/1463272612000"
webtalk_add_data -client sdk -key apptemplate -value "zynq_fsbl" -context "sdk\\\\application/1463272612000"
webtalk_transmit -clientid 3834700738 -regid "" -xml /home/harsha/work/Zynq/workspace/Audio_Mixer_1.1/Audio_Mixer_1.1.sdk/webtalk/usage_statistics_ext_sdk.xml -html /home/harsha/work/Zynq/workspace/Audio_Mixer_1.1/Audio_Mixer_1.1.sdk/webtalk/usage_statistics_ext_sdk.html -wdm /home/harsha/work/Zynq/workspace/Audio_Mixer_1.1/Audio_Mixer_1.1.sdk/webtalk/sdk_webtalk.wdm -intro "<H3>SDK Usage Report</H3><BR>"
webtalk_terminate
