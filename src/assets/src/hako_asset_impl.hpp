#ifndef _HAKO_ASSET_IMPL_HPP_
#define _HAKO_ASSET_IMPL_HPP_

#include "hako_asset.h"
#include "hako.hpp"
#include "nlohmann/json.hpp"
#include <fstream>
#include <iostream>
#include "stdio.h"
#include "assert.h"

#define HAKO_ASSET_ASSERT(expr)	\
do {	\
	if (!(expr))	{	\
		printf("HAKO ASSERTION FAILED:%s:%s:%d:%s", __FILE__, __FUNCTION__, __LINE__, #expr);	\
		assert(!(expr));	\
	}	\
} while (0)

using json = nlohmann::json;


struct PduReader {
    std::string type;
    std::string org_name;
    std::string name;
    int channel_id;
    int pdu_size;
};

struct PduWriter {
    std::string type;
    std::string org_name;
    std::string name;
    int write_cycle;
    int channel_id;
    int pdu_size;
    std::string method_type;
};
struct Robot {
    std::string name;
    std::vector<PduReader> pdu_readers;
    std::vector<PduWriter> pdu_writers;
};

struct HakoAssetType {
    bool is_initialized;
    std::string asset_name_str;
    hako_time_t delta_usec;
    hako_time_t current_usec;
    json param;
    const hako_asset_callbacks_t *callback;
    std::shared_ptr<hako::IHakoAssetController> hako_asset;
    std::shared_ptr<hako::IHakoSimulationEventController> hako_sim;
    std::vector<Robot> robots;
};

extern HakoAssetType hako_asset_instance;
#define WAIT_TIME_USEC (1000 * 10)

extern bool hako_asset_impl_register_callback(const hako_asset_callbacks_t* callback);
extern bool hako_asset_impl_init(const char* asset_name, const char* config_path, hako_time_t delta_usec);
extern bool hako_asset_impl_wait_running(void);
extern HakoSimulationStateType hako_asset_impl_state();
extern bool hako_asset_impl_step(hako_time_t increment_step);
extern hako_time_t hako_asset_impl_get_world_time();
extern bool hako_asset_impl_pdu_read(const char* robo_name, HakoPduChannelIdType lchannel, char* buffer, size_t buffer_len);
extern bool hako_asset_impl_pdu_write(const char* robo_name, HakoPduChannelIdType lchannel, const char* buffer, size_t buffer_len);

#endif /* _HAKO_ASSET_IMPL_HPP_ */