/*
 * Copyright (C) 2019 ATGDroid <bythedroid@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
 

#include <fstream>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/mount.h>
#include <unistd.h>
#define _REALLY_INCLUDE_SYS__SYSTEM_PROPERTIES_H_
#include <sys/_system_properties.h>

namespace android {
namespace init {

struct teamhorizon_required_prop {
    const std::string prop;
};

const struct teamhorizon_required_prop teamhorizon_required_props[] = {
	{ "ro.build.fingerprint" },
	{ "ro.build.description" },
	{ "ro.build.version.incremental" },
	{ "ro.build.version.release" },
	{ "" },
};

void property_update(char const prop[], char const value[]) {
    prop_info *pi;
    
    pi = (prop_info*) __system_property_find(prop);
    if (pi)
        __system_property_update(pi, value, strlen(value));
    else
        __system_property_add(prop, strlen(prop), value, strlen(value));
}

void vendor_load_properties() {
	const std::string mnt = "/s", property_file = mnt + "/build.prop";
	mkdir(mnt.c_str(), 755);
	mount("/dev/block/bootdevice/by-name/system", mnt.c_str(), "ext4", MS_RDONLY, NULL);
    struct stat st;
  if(stat(property_file.c_str(), &st) == 0) {
  std::ifstream file(property_file.c_str());
  if (file.is_open()) {
  std::string local, value;
  size_t pos;
  while (getline(file, local)) {
  const struct teamhorizon_required_prop *required_props = teamhorizon_required_props;
  while (!required_props->prop.empty()) {
      if (required_props->prop[0] == local[0] && 
         ((pos = local.find_first_of("=")) != std::string::npos) &&
          local.substr(0, pos) == required_props->prop) {
          value = local.substr(pos + 1);
          property_update(required_props->prop.c_str(), value.c_str());
       }
       required_props++;
     }
    }
   }
 }  
    umount(mnt.c_str());
    rmdir(mnt.c_str());
}
}  // namespace init
}  // namespace android
