<template>
    <div>
        <el-card class="box-card">
            <div slot="header" class="clearfix">
                <span>今日预约</span>
            </div>
            <el-table :data="tableDataToday" border stripe>

                <el-table-column prop="id" label="预约单号" width="140">
                </el-table-column>
                <el-table-column prop="roomId" label="教室名称">
                </el-table-column>
                <el-table-column prop="sitId" label="座位号">
                </el-table-column>
                <el-table-column prop="startTime" label="开始时间">
                </el-table-column>
                <el-table-column prop="endTime" label="结束时间">
                </el-table-column>
                <el-table-column prop="reservedTime" label="预约订单时间">
                </el-table-column>

                <el-table-column prop="option" label="操作">
                    <template slot-scope="scope">
                        <el-button type="primary" v-loading.fullscreen.lock="fullscreenLoading"
                            @click="handleSignIn(scope.row)">签到 <i class="el-icon-s-claim"></i></el-button>

                        <el-popconfirm class="ml-5" confirm-button-text='确定' cancel-button-text='我再想想' icon="el-icon-info"
                            icon-color="red" title="您确定取消预约吗？" @confirm="handleCancel(scope.row.id)">
                            <el-button type="danger" slot="reference">取消预约 <i
                                    class="el-icon-remove-outline"></i></el-button>
                        </el-popconfirm>
                    </template>
                </el-table-column>
            </el-table>

        </el-card>

        <el-card class="box-card">
            <div slot="header" class="clearfix">
                <span>未来预约</span>

            </div>

            <el-table :data="tableDataFuture" border stripe>

                <el-table-column prop="id" label="预约单号" width="140">
                </el-table-column>
                <el-table-column prop="roomId" label="教室名称">
                </el-table-column>
                <el-table-column prop="sitId" label="座位号">
                </el-table-column>
                <el-table-column prop="startTime" label="开始时间">
                </el-table-column>
                <el-table-column prop="endTime" label="结束时间">
                </el-table-column>
                <el-table-column prop="reservedTime" label="预约订单时间">
                </el-table-column>

                <el-table-column prop="option" label="操作">
                    <template slot-scope="scope">

                        <el-popconfirm class="ml-5" confirm-button-text='确定' cancel-button-text='我再想想' icon="el-icon-info"
                            icon-color="red" title="您确定取消预约吗？" @confirm="handleCancel(scope.row.id)">

                            <el-button type="danger" slot="reference">取消预约 <i
                                    class="el-icon-remove-outline"></i></el-button>

                        </el-popconfirm>
                    </template>
                </el-table-column>
            </el-table>

        </el-card>

        <el-card class="box-card" v-if="userRole === 'ROLE_ADMIN'">
            <div slot="header" class="clearfix">
                <span>已过期预约</span>

            </div>
            <el-table :data="tableDataExpired" border stripe>

                <el-table-column prop="id" label="预约单号" width="140">
                </el-table-column>
                <el-table-column prop="roomId" label="教室名称">
                </el-table-column>
                <el-table-column prop="sitId" label="座位号">
                </el-table-column>
                <el-table-column prop="startTime" label="开始时间">
                </el-table-column>
                <el-table-column prop="endTime" label="结束时间">
                </el-table-column>
                <el-table-column prop="reservedTime" label="预约订单时间">
                </el-table-column>
                <el-table-column label="是否签到">
                    <template slot-scope="scope">
                        <el-switch v-model="scope.row.checkInTime" active-color="#13ce66" inactive-color="#ccc"
                            disabled></el-switch>
                    </template>
                </el-table-column>
                <el-table-column label="是否取消">
                    <template slot-scope="scope">
                        <el-switch v-model="scope.row.cancle" active-color="#13ce66" inactive-color="#ccc"
                            disabled></el-switch>
                    </template>
                </el-table-column>
                <el-table-column label="是否违约">
                    <template slot-scope="scope">
                        <el-switch v-model="scope.row.breakContract" active-color="#13ce66" inactive-color="#ccc"
                            disabled></el-switch>
                    </template>
                </el-table-column>
                <el-table-column prop="option" label="操作">
                    <template slot-scope="scope">
                        <router-link :to="{name: '座位预定', params: {id: scope.row.sitId}}">
                            <el-button>
                                再次预约 
                                <i class="el-icon-s-check"></i>
                            </el-button>
                        </router-link>
                    </template>
                </el-table-column>
            </el-table>

        </el-card>
    </div>
</template>
  
<script>
import MapLoader from "../utils/gaode"
export default {
    name: "MyReserve",
    data() {
        return {
            tableDataToday: [],
            tableDataFuture: [],
            tableDataExpired: [],
            pageNum: 1,
            pageSize: -1,
            username: JSON.parse(localStorage.getItem("user")).username,
            fullscreenLoading: false,
        }
    },
    created() {
        this.load()
    },
    methods: {
        handleCancel(id) {
            this.request.post("/reserve/cancel_reserve", {
                id: id
            }).then(res => {
                console.log(res)
                if (res.code === '200') {
                    this.$message.success("取消成功")
                    this.load()
                } else {
                    this.$message.error("取消失败")
                }
            })
        },
        load() {
            return new Promise((resolve, reject) => {
                this.request.get("/reserve/check_reserve", {
                    params: {
                        pageNum: this.pageNum,
                        pageSize: this.pageSize,
                        username: this.username
                    }
                }).then(res => {
                    this.tableDataToday = [];
                    this.tableDataFuture = [];
                    this.tableDataExpired = [];
                    let tableData = res.data.records;
                    let total = tableData.length;
                    for (let i = 0; i < total; i++) {
                        if (tableData[i].breakContract === true || tableData[i].cancle === true || tableData[i].checkInTime === true) {
                            this.tableDataExpired.push(tableData[i]);
                        } else if (tableData[i].breakContract === false && tableData[i].cancle === false && tableData[i].checkInTime === false) {
                            const startTime = tableData[i].startTime.split(" ")[0];
                            const currentDate = new Date();
                            const year = currentDate.getFullYear();
                            const month = String(currentDate.getMonth() + 1).padStart(2, '0');
                            const day = String(currentDate.getDate()).padStart(2, '0');
                            const todayDate = `${year}-${month}-${day}`;
                            if (startTime === todayDate) {
                                this.tableDataToday.push(tableData[i]);
                            } else {
                                this.tableDataFuture.push(tableData[i]);
                            }
                        }
                    }
                    resolve();
                }).catch(error => {
                    reject(error);
                });
            });
        },
        handleSignIn(row) {
            this.fullscreenLoading = true;
            setTimeout(() => {
                const currentDate = new Date();
                const currentHours = currentDate.getHours();
                const currentMinutes = currentDate.getMinutes();
                const startTime = row.startTime.split(" ")[1];
                const startHour = startTime.split(":")[0];
                const startMinute = startTime.split(":")[1];
                const timeValue1 = parseInt(currentHours, 10) * 60 + parseInt(currentMinutes, 10);
                const timeValue2 = parseInt(startHour, 10) * 60 + parseInt(startMinute, 10);
                const minuteDifference = timeValue1 - timeValue2;

                if (minuteDifference < -5) {
                    this.$message.error("未到签到时间，请在开始时间前五分钟至后十五分钟内签到");
                    this.fullscreenLoading = false;
                } else {
                    console.log("开始定位！");
                    MapLoader().then(isWithinDistance => {
                        if (isWithinDistance) {
                            console.log(row.id);
                            return this.request.post("/reserve/confirm_reserve", {
                                id: row.id
                            });
                        } else {
                            throw new Error("签到失败，您不在指定位置范围内");
                        }
                    }).then(res => {
                        if (res.code === '200') {
                            this.$message.success("签到成功");
                            return this.load(); // 重新加载数据以更新界面
                        } else {
                            throw new Error("签到失败");
                        }
                    }).then(() => {
                        this.fullscreenLoading = false; // 在重新加载数据完成后设置为false
                    }).catch(error => {
                        this.$message.error(error.message || "签到失败");
                        this.fullscreenLoading = false; // 确保在所有操作完成后设置为false
                    });
                }
            }, 2000);
        },
        handleReEdit(row) {
            this.$router.push("/NewReserve")
            console.log(row.sitId)
        }
    }
}
</script>


<style>
.text {
    font-size: 14px;
}

.item {
    margin-bottom: 18px;
}

.clearfix:before,
.clearfix:after {
    display: table;
    content: "";
}

.clearfix:after {
    clear: both
}

.box-card {
    width: 100%;
    margin-bottom: 20px;
}

.headerBg {
    background: #eee !important;
}
</style>