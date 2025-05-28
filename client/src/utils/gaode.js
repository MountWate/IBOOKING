// utils/gaode.js
export default function MapLoader() {
    return new Promise((resolve, reject) => {
        let aMapScript = document.createElement('script');
        aMapScript.setAttribute('src', 'https://webapi.amap.com/maps?v=1.4.11&key=4c05c18accf6cc90f136f850ac696c66&plugin=AMap.CitySearch,AMap.Geolocation,AMap.GeometryUtil');
        document.head.appendChild(aMapScript);
        aMapScript.onload = function() {
            AMap.plugin(['AMap.Geolocation', 'AMap.GeometryUtil'], function() {
                var geolocation = new AMap.Geolocation({
                    enableHighAccuracy: true,
                    timeout: 10000,
                    buttonOffset: new AMap.Pixel(10, 20),
                    zoomToAccuracy: true,
                    buttonPosition: 'RB'
                });

                geolocation.getCurrentPosition();
                AMap.event.addListener(geolocation, 'complete', onComplete);
                AMap.event.addListener(geolocation, 'error', onError);

                function onComplete(data) {
                    console.log('定位成功', data.position)
                    // A教位置
                    const targetPosition = new AMap.LngLat(121.503807, 31.336037);
                    const currentPosition = new AMap.LngLat(data.position.lng, data.position.lat);
                    const distance = AMap.GeometryUtil.distance(currentPosition, targetPosition);
                    console.log('定位成功', data.position, '距离目标点', distance, '米')
                    resolve(distance <= 500); 
                }

                function onError(data) {
                    console.log('定位失败', data)
                    reject(new Error('定位出错，请确认已开启定位权限'));
                }
            });
        };
        aMapScript.onerror = function() {
            reject(new Error('地图脚本加载失败'));
        };
    });
}
