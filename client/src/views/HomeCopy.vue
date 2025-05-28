<template>
    <div>


        <div style="display:flex; margin-top: 100px;">
            <!--      左边的选择座位-->
            <div style="display: flex; padding-left:400px; flex-wrap: wrap; cursor: pointer; flex: 80%">
                <div :class="[index === currentIndex ? 'select-class' : 'class-item']" @click="selectClass(index)"
                    v-for="(item, index) in classData">
                    <div v-if="item.selected === 1" class="seat-locked">
                        {{ classData[index].sitId }}
                    </div>
                    <div v-else-if="item.chargePort === '1'"
                        :class="[index === currentIndex ? 'select-class' : 'class-item2']">
                        {{ classData[index].sitId }}
                    </div>
                    <div v-else>
                        {{ classData[index].sitId }}
                    </div>
                </div>
            </div>

            <!--      右边的选择信息-->
            <div style="flex: 20%;">
                <div>选择的座位：</div>
                <div style="margin-top: 20px;display: flex">
                    <div style="rgb(148,148,148);font-weight:700; background:rgb(247,247,247); padding: 10px">
                        {{ sitId }} 号
                    </div>
                </div>
                <div style="margin-top: 20px">
                    <el-button type="primary" @click="selectSeat">确认选座</el-button>
                </div>
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

        </div>

    </div>
</template>

<script>

export default {
    name: "Home",
    data() {
        return {
            classData: {},
            currentIndex: -1,
            sitId: ''
        }
    },
    methods: {
        selectClass(index) {
            if (this.classData[index].selected === 0) {
                this.currentIndex = index
                this.sitId = this.classData[index].sitId
                console.log(this.currentIndex)
                console.log(index)
            } else {
                this.$message.error("该座位已被占")
            }

        },
        selectSeat() {

        }
    },
    created() {
        this.classData = [
            {
                "sitId": "300",
                "roomId": "15",
                "chargePort": "1",
                "selected": 1
            },
            {
                "sitId": "301",
                "roomId": "15",
                "chargePort": "0",
                "selected": 1
            },
            {
                "sitId": "302",
                "roomId": "15",
                "chargePort": "1",
                "selected": 1
            },
            {
                "sitId": "303",
                "roomId": "15",
                "chargePort": "0",
                "selected": 1
            },
            {
                "sitId": "304",
                "roomId": "15",
                "chargePort": "1",
                "selected": 0
            },
            {
                "sitId": "305",
                "roomId": "15",
                "chargePort": "0",
                "selected": 0
            },
            {
                "sitId": "306",
                "roomId": "15",
                "chargePort": "1",
                "selected": 1
            },
            {
                "sitId": "307",
                "roomId": "15",
                "chargePort": "1",
                "selected": 0
            },
            {
                "sitId": "308",
                "roomId": "15",
                "chargePort": "0",
                "selected": 0
            },
            {
                "sitId": "309",
                "roomId": "15",
                "chargePort": "0",
                "selected": 0
            },
            {
                "sitId": "310",
                "roomId": "15",
                "chargePort": "0",
                "selected": 1
            },
            {
                "sitId": "311",
                "roomId": "15",
                "chargePort": "0",
                "selected": 0
            },
            {
                "sitId": "312",
                "roomId": "15",
                "chargePort": "0",
                "selected": 0
            },
            {
                "sitId": "313",
                "roomId": "15",
                "chargePort": "0",
                "selected": 1
            },
            {
                "sitId": "314",
                "roomId": "15",
                "chargePort": "1",
                "selected": 0
            },
            {
                "sitId": "315",
                "roomId": "15",
                "chargePort": "0",
                "selected": 1
            },
            {
                "sitId": "316",
                "roomId": "15",
                "chargePort": "0",
                "selected": 1
            },
            {
                "sitId": "317",
                "roomId": "15",
                "chargePort": "0",
                "selected": 0
            },
            {
                "sitId": "318",
                "roomId": "15",
                "chargePort": "0",
                "selected": 1
            },
            {
                "sitId": "319",
                "roomId": "15",
                "chargePort": "0",
                "selected": 1
            }
        ]
    }
}
</script>

<style scoped>
.status-dot {
    display: inline-block;
    width: 10px;
    height: 10px;
    border-radius: 50%;
    background-color: #2c2c2c;
    margin-right: 5px;
    vertical-align: middle; /* 将垂直对齐方式设置为 middle */
  }
  
  .status-dot::before {
    content: "";
    display: inline-block;
    width: 6px;
    height: 6px;
    border-radius: 50%;
    background-color: white;
    margin: 2px;
  }

.select-class {
    border-radius: 13px;
    color: white;
    min-height: 50px;
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
    min-height: 50px;
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