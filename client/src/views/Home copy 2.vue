<template>
    <div>
        <div id="main" style="width: 500px; height: 400px;"></div>
        
    </div>
</template>

<script>
import * as echarts from "echarts"

export default {
    name: "Home",
    data() {
        return {
           
        }
    },
    mounted() { // 页面元素创建好再触发
        var chartDom = document.getElementById("main");
        var myChart = echarts.init(chartDom);
        var option = {
            title: {
                text: '各季度会员数量统计',
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
        
    }

}
</script>

<style scoped></style>