<template>
    <div>
        <el-row :gutter="10" style="margin-bottom: 20px; height: 10vh;">
            <el-col :span="8">
                <el-card class="box-card-home">
                    <div slot="header" class="clearfix" style="color: #409EFF;">
                        <span>用户总数</span>
                    </div>
                    <div style="padding: 10px 0; text-align: center; font-weight: bold;">
                        {{ userNum }}
                    </div>
                </el-card>
            </el-col>

            <el-col :span="8">
                <el-card class="box-card-home">
                    <div slot="header" class="clearfix" style="color: #67C23A;">
                        <span>教室总数</span>
                    </div>
                    <div style="padding: 10px 0; text-align: center; font-weight: bold;">
                        {{ roomNum }}
                    </div>
                </el-card>
            </el-col>

            <el-col :span="8">
                <el-card class="box-card-home">
                    <div slot="header" class="clearfix" style="color: #E6A23C;">
                        <span>今日预约总数</span>
                    </div>
                    <div style="padding: 10px 0; text-align: center; font-weight: bold;">
                        {{ reserveNum }}
                    </div>
                </el-card>
            </el-col>
        </el-row>

        <el-row :gutter="10" style="margin-bottom: 20px;">
            <el-col :span="8">
                <div id="main1" style="width: 100%; height: 30vh;"></div>
            </el-col>
            <el-col :span="8">
                <div id="main2" style="width: 100%; height: 30vh;"></div>
            </el-col>
            <el-col :span="8">
                <div id="main3" style="width: 100%; height: 30vh;"></div>
            </el-col>
        </el-row>


        <el-card class="box-card" v-if="userRole === 'ROLE_ADMIN'">
            <div slot="header" class="clearfix">
                <span>今日预约订单</span>
            </div>
            <el-table :data="tableDataToday" border stripe>

                <el-table-column prop="id" label="预约单号" width="140">
                </el-table-column>
                <el-table-column prop="username" label="用户名称" v-if="userRole === 'ROLE_ADMIN'">
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

            </el-table>

            <div style="padding: 10px 0;">
                <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page="pageNum"
                    :page-sizes="[2, 5, 10, 20]" :page-size="pageSize" layout="total, sizes, prev, pager, next, jumper"
                    :total="total">
                </el-pagination>
            </div>

        </el-card>


    </div>
</template>

<script>
import * as echarts from "echarts"
export default {
    name: "Home",
    data() {
        return {
            tableDataToday: [],
            pageNum: 1,
            pageSize: 20,
            name: "admin",
            total: 0,
            userNum: 0,
            roomNum: 0,
            reserveNum: 0,
            userRole: JSON.parse(localStorage.getItem("user")).role,
        }
    },
    created() {
        this.load()
    },
    mounted() { // 页面元素创建好再触发
        this.echarts1()
        this.echarts2()
        this.echarts3()
    },
    methods: {
        echarts1() {
            var chartDom = document.getElementById("main1");
            var myChart = echarts.init(chartDom);
            var option = {
                title: {
                    text: '各季度用户数量统计',
                    subtext: '趋势图',
                    left: 'center'
                },
                xAxis: {
                    type: 'category',
                    data: ["第一季度", "第二季度", "第三季度", "第四季度"]
                },
                yAxis: {
                    type: 'value'
                },
                series: [
                    {
                        data: [],
                        type: 'line'
                    },
                    {
                        data: [],
                        type: 'bar'
                    }
                ]
            };
            this.request.get("/echarts/members").then(res => {
                option.series[0].data = res.data
                option.series[1].data = res.data
                myChart.setOption(option)
            })
            window.addEventListener('resize', () => {
                myChart.resize()
            })

        },
        echarts2() {
            var chartDom = document.getElementById("main2");
            var myChart = echarts.init(chartDom);
            var option = {
                title: {
                    text: '教室分类统计',
                    left: 'center'
                },
                tooltip: {
                    trigger: 'item'
                },
                legend: {
                    orient: 'vertical',
                    left: 'left'
                },
                series: [
                    {
                        name: '教室间数',
                        type: 'pie',
                        radius: ['40%', '60%'],
                        data: [],
                        emphasis: {
                            itemStyle: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            }
            this.request.get("/home/info", {}).then(res => {
                const echarts2Data = [
                    { value: res.data.smallRoom, name: '小教室' },
                    { value: res.data.largeRoom, name: '大教室' },
                    { value: res.data.readingRoom, name: '阅览室' },
                    { value: res.data.library, name: '图书馆' }
                ]
                option.series[0].data = echarts2Data
                myChart.setOption(option)

            })
            window.addEventListener('resize', () => {
                myChart.resize()
            })
        },
        echarts3() {
            var chartDom = document.getElementById("main3");
            var myChart = echarts.init(chartDom);
            var option = {
                title: {
                    text: '今日预约状态统计',
                    left: 'center'
                },
                tooltip: {
                    trigger: 'item'
                },
                legend: {
                    orient: 'vertical',
                    left: 'left'
                },
                series: [
                    {
                        name: '统计单数',
                        type: 'pie',
                        radius: '60%',
                        data: [],
                        emphasis: {
                            itemStyle: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            }
            this.request.get("/home/info", {}).then(res => {
                const echarts3Data = [
                    { value: res.data.breakNumber, name: '已违约' },
                    { value: res.data.cancleNumber, name: '已取消' },
                    { value: res.data.checkInNumber, name: '已签到' },
                    { value: res.data.otherNumber, name: '未签到' }
                ]
                option.series[0].data = echarts3Data
                myChart.setOption(option)

            })
            window.addEventListener('resize', () => {
                myChart.resize()
            })
        },
        load() {
            this.request.get("/home/info", {}).then(res => {
                this.userNum = res.data.userNumber
                this.roomNum = res.data.roomNumber
                this.reserveNum = res.data.reserveNumber
            })
            this.request.get("/home/today_reserve", {
                params: {
                    pageNum: this.pageNum,
                    pageSize: this.pageSize
                }
            }).then(res => {
                this.tableDataToday = res.data.records
                this.total = res.data.total
            })
        },
        handleSizeChange(pageSize) {
            this.pageSize = pageSize
            this.load()
        },
        handleCurrentChange(pageNum) {
            this.pageNum = pageNum
            this.load()
        }
    }

}
</script>

<style scoped>
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

.box-card-home {
    width: 100%;
    margin-bottom: 20px;
}
</style>