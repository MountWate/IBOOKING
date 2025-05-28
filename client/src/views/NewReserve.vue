<template>
    <div>
        <div style="padding: 10px 0;">
            <el-input style="width: 200px" suffix-icon="el-icon-search" :placeholder="'搜索' + searchSwitch"
                v-model="name"></el-input>
            <el-select style="width: 80px; margin-left: 5px;" v-model="searchSwitch" placeholder="请选择">
                <el-option v-for="item in searchOptions" :key="item.value" :label="item.label" :value="item.value">
                </el-option>
            </el-select>
            <el-button style="margin-left: 5px;" type="primary" @click="search">搜索</el-button>
            <el-button @click="reset">重置</el-button>
            <el-button style="margin-left: 5px;" type="primary" @click="rush">抢座</el-button>
        </div>
        <el-table :data="tableData" border stripe>

            <el-table-column prop="id" label="教室ID">
            </el-table-column>
            <el-table-column prop="name" label="教室名称">
            </el-table-column>
            <el-table-column prop="type" label="教室类型">
            </el-table-column>
            <el-table-column label="是否可用">
                <template slot-scope="scope">
                    <el-switch v-model="scope.row.available" active-color="#13ce66" inactive-color="#ccc"
                        disabled></el-switch>
                </template>
            </el-table-column>
            <el-table-column prop="openTime" label="开放时间">
            </el-table-column>
            <el-table-column prop="closeTime" label="关闭时间">
            </el-table-column>
            <el-table-column prop="option" label="操作">
                <template slot-scope="scope">
                    <el-button @click="handleEdit(scope.row)">预约 <i class="el-icon-s-check"></i></el-button>
                </template>
            </el-table-column>
        </el-table>

        <div style="padding: 10px 0;">
            <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page="pageNum"
                :page-sizes="[2, 5, 10, 20]" :page-size="pageSize" layout="total, sizes, prev, pager, next, jumper"
                :total="total">
            </el-pagination>
        </div>

        <el-dialog title="座位预定" :visible.sync="dialogFormVisible" width="70%">
            <el-row :gutter="20" style="margin-bottom: 20px; height: auto;">
                <el-col :span="18" style="height: 100%;">
                    <el-card class="box-card-home" style="height: 100%;">
                        <div slot="header" class="clearfix" style="color: #409EFF; height: 10%;">
                            <span>教室名称：{{ classroom }}</span>
                        </div>
                        <div style="height: 90%;">

                            <!-- 选座位 -->
                            <div style="display: flex; flex-wrap: wrap; cursor: pointer; flex: 80%">
                                <div :class="[index === currentIndex ? 'select-class' : 'class-item']"
                                    @click="selectClass(index)" style="  margin-bottom: 20px;"
                                    v-for="(item, index) in classData" :key="index">
                                    <div v-if="!item.available" class="seat-locked">
                                        {{ classData[index].id }}
                                    </div>
                                    <div v-else-if="item.chargeport"
                                        :class="[index === currentIndex ? 'select-class' : 'class-item2']">
                                        {{ classData[index].id }}
                                    </div>
                                    <div v-else>
                                        {{ classData[index].id }}
                                    </div>
                                </div>
                            </div>

                        </div>

                    </el-card>
                </el-col>

                <el-col :span="6" style="height: 100%;">
                    <el-form label-width="30%">
                        <el-form-item label="日期选择">
                            <el-date-picker v-model="selectDate" type="date" style="width: 80%;"
                                :picker-options="pickerOptions" value-format="yyyy-MM-dd" @change="loadSeat()">
                            </el-date-picker>
                        </el-form-item>

                        <el-form-item label="开始时间">
                            <el-time-select v-model="selectStart" :picker-options="{
                                start: optionStart,
                                step: '01:00',
                                end: '21:00'
                            }" style="width: 80%;" @change="loadSeat()">
                            </el-time-select>
                        </el-form-item>

                        <el-form-item label="结束时间">
                            <el-time-select v-model="selectEnd" :picker-options="{
                                start: optionEnd,
                                step: '01:00',
                                end: '22:00'
                            }" style="width: 80%;" @change="loadSeat()">
                            </el-time-select>
                        </el-form-item>

                        <el-form-item label="座位选择">
                            <div style="color: rgb(0, 0, 0)">
                                {{ sitId }} 号
                            </div>
                        </el-form-item>
                    </el-form>
                    <div style="padding: 15px; ">
                        <div style="margin-top: 10px">
                            <span class="status-dot"></span>空闲-有插座
                        </div>
                        <div style="margin-top: 10px">
                            <span class="status-dot" style="background-color: #8a8a8a;"></span>空闲-无插座
                        </div>
                        <div style="margin-top: 10px">
                            <span class="status-dot" style="background-color: #d81e06;"></span>已被占
                        </div>
                        <div style="margin-top: 10px">
                            <span class="status-dot" style="background-color: #43d828;"></span>选中
                        </div>
                    </div>
                </el-col>

            </el-row>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogFormVisible = false">取 消</el-button>
                <el-button type="primary" @click="save">确 定</el-button>
            </div>
        </el-dialog>
    </div>
</template>

<script>
export default {
    name: "NewReserve",
    data() {
        return {
            name: "",
            searchSwitch: '教室',
            searchOptions: [
                {
                    value: '教室',
                    label: '教室'
                },
                {
                    value: '座位',
                    label: '座位'
                }
            ],
            pageNum: 1,
            pageSize: 20,
            total: 10,
            tableData: [],
            dialogFormVisible: false,
            classroom: '',
            classData: {},
            idList: [],//未被占用的座位号
            currentIndex: -1,
            sitId: '---',
            selectDate: '',
            selectStart: '',
            selectEnd: '',
            roomId: -1,
            optionStart: '',
            optionEnd: '',
            pickerOptions: {
                disabledDate(time) {
                    const today = new Date(); // 获取今天的日期
                    const targetDate = new Date(time.getFullYear(), time.getMonth(), time.getDate()); // 获取目标日期
                    const difference = (targetDate - today) / (24 * 60 * 60 * 1000); // 计算目标日期与今天的天数差

                    // 只允许选择今天和今天之后三天的日期
                    return difference < -1 || difference > 3;
                }
            },

        }
    },
    created() {
        this.load()
        this.classData = []
        // console.log(this.$route.params.id);
        if (this.$route.params.id !== undefined) {
            this.name = this.$route.params.id
            this.searchSwitch = '座位'
            this.seatRoom()
        }
    },
    methods: {
        search() {
            if (this.searchSwitch === '教室') {
                this.load()
            } else {
                this.seatRoom()
            }
        },
        //抢座功能，随机分配一个未被占用的座位号，调用seatRoom
        rush() {
          //从数据库中获取所有未被占用的座位号，随机分配一个
            this.request.get("/sit/all_sits").then(res => {
                //获取所有未被占用的座位号
                this.idList = res.data.filter(item => item.available === true)
                if (this.idList.length === 0) {
                    this.$message.error("当前没有可用座位")
                } else {
                    this.name = this.idList[Math.floor(Math.random() * this.idList.length)].id
                    this.searchSwitch = '座位'
                    this.seatRoom()
                }
            })
        },
        load() {
            this.request.get("/room/check_room", {
                params: {
                    pageNum: this.pageNum,
                    pageSize: this.pageSize,
                    name: this.name
                }
            }).then(res => {
                this.tableData = res.data.records
                this.total = res.data.total
            })

        },
        seatRoom() {
            if (Number(this.name)) {
                this.request.get("/sit/reserve_sit", {
                    params: {
                        id: this.name
                    }
                }).then(res => {
                    if (res.code === '200') {
                        this.handleEdit(res.data)
                        setTimeout(() => {
                            for (let i = 0; i < this.classData.length; i++) {
                                console.log(this.classData[i].id)
                                console.log(this.name)
                                if (this.classData[i].id === Number(this.name)) {
                                    console.log(this.classData[i].id)
                                    if (this.classData[i].available === true) {
                                        this.sitId = this.name
                                        this.currentIndex = i
                                    } else {
                                        this.sitId = "---"
                                        this.currentIndex = -1
                                        this.$message.error("当前位置已被选，请选择其他座位或其他时间段")
                                    }
                                }
                            }
                        }, 1000);
                    } else {
                        this.$message.error(res.msg)
                    }
                })
            } else {
                this.$message.error("座位号输入有误")
            }

        },
        reset() {
            this.name = ""
            this.load()
        },
        handleEdit(row) {
            if (!row.available) {
                this.$message.error("该教室不可用，请选择其他教室")
            } else {
                this.classroom = row.name
                this.dialogFormVisible = true
                this.getTime()
                this.roomId = row.id
                this.loadSeat()
            }

        },
        getTime() {
            const dateToday = new Date()
            this.selectDate = dateToday.getFullYear() + "-" + (dateToday.getMonth() + 1) + "-" + dateToday.getDate()
            this.selectStart = dateToday.getHours() + 1 + ":00"
            this.selectEnd = dateToday.getHours() + 2 + ":00"
            this.optionStart = this.selectStart
            this.optionEnd = this.selectEnd
        },
        loadSeat() {
            if (this.selectDate !== null && this.selectStart !== null && this.selectEnd !== null) {
                if (this.selectDate.split("-")[2] !== new Date().getDate()) {
                    this.optionStart = "07:00"
                    this.optionEnd = "08:00"
                }
                const startHour = parseInt(this.selectStart.split(":")[0])
                const EndHour = parseInt(this.selectEnd.split(":")[0])
                if (startHour < EndHour) {
                    this.request.get("/room/check_sits", {
                        params: {
                            id: this.roomId,
                            day: this.selectDate,
                            start: this.selectStart,
                            end: this.selectEnd,
                        }
                    }).then(res => {
                        this.classData = res.data
                        if (this.currentIndex !== -1 && this.classData[this.currentIndex].available === false) {
                            this.sitId = "---"
                            this.currentIndex = -1
                        }
                    })
                }



            }

        },
        handleSizeChange(pageSize) {
            this.pageSize = pageSize
            this.load()
        },
        handleCurrentChange(pageNum) {
            this.pageNum = pageNum
            this.load()
        },
        save() {
            if (this.selectDate !== null && this.selectStart !== null && this.selectEnd !== null) {
                const startHour = parseInt(this.selectStart.split(":")[0])
                const EndHour = parseInt(this.selectEnd.split(":")[0])
                if (this.sitId !== "---") {
                    if (startHour > EndHour) {
                        this.$message.error("时间选择有误")
                    } else if (EndHour - startHour > 4) {
                        this.$message.error("超出4小时时间范围")
                    } else {
                        this.request.post("/reserve/create_reserve", {
                            username: JSON.parse(localStorage.getItem("user")).username,
                            roomId: this.roomId,
                            sitId: this.sitId,
                            startTime: this.selectDate + " " + this.selectStart,
                            endTime: this.selectDate + " " + this.selectEnd
                        }).then(res => {
                            if (res.code === '200') {
                                this.$message.success("预约成功")
                            } else {
                                this.$message.error("预约失败，请重新选座")
                            }
                            this.loadSeat()
                        })
                    }
                } else {
                    this.$message.error("您还未选择座位")
                }
            } else {
                this.$message.error("您的预约信息未填写完整")
            }

        },
        selectClass(index) {
            if (this.classData[index].available === true) {
                this.currentIndex = index
                this.sitId = this.classData[index].id
            } else {
                this.$message.error("该座位已被占")
            }

        },

    }
}
</script>

<style>
.status-dot {
    display: inline-block;
    width: 10px;
    height: 10px;
    border-radius: 50%;
    background-color: #2c2c2c;
    margin-right: 5px;
    vertical-align: middle;
    /* 将垂直对齐方式设置为 middle */
}

.select-class {
    border-radius: 13px;
    color: white;
    height: 50px;
    background-image: url(../assets/seatselecting.png);
    background-repeat: no-repeat;
    background-position: top;
    width: 19%;
    display: flex;
    justify-content: center;
    align-items: center;

}

.class-item {
    border-radius: 13px;
    color: white;
    height: 50px;
    background-image: url(../assets/seatfreewithoutplug.png);
    background-repeat: no-repeat;
    background-position: top;
    width: 19%;
    display: flex;
    justify-content: center;
    align-items: center;
}

.class-item2 {
    background-image: url(../assets/seatfreewithplug.png);
    background-repeat: no-repeat;
    background-position: top;
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center
}

.prompt-text {
    margin: 0 10px;
    padding: 8px;
    background: rgb(179, 216, 255);
    color: rgb(83, 168, 255);
    border-radius: 15px
}

.seat-locked {
    background-image: url(../assets/seatlocked.png);
    background-repeat: no-repeat;
    background-position: top;
    width: 100%;
    height: 100%;
    border-radius: 15px;
    display: flex;
    justify-content: center;
    align-items: center
}
</style>
