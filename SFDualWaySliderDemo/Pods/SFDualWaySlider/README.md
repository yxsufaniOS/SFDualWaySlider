# SFDualWaySlider



双向滑块

#可设置分段，滑块间的隔值。


![](https://github.com/yxsufaniOS/SFDualWaySlider/blob/master/图示.png)

## 安装

To use SFDualWaySlider add the following to your Podfile

pod 'SFDualWaySlider'

or 

或者直接把“SFDualWaySlider”文件夹拉到项目中.

## 使用

### 分段：部分滑块的需求可能不是整个滑块均分的，经常会使用到的值范围可以占据较大比例，更人性化。

````
SFDualWaySlider *slider = [[SFDualWaySlider alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 70) minValue:0 maxValue:80 blockSpaceValue:2];
slider.progressRadius = 5;
[slider.minIndicateView setTitle:@"不限"];
[slider.maxIndicateView setTitle:@"不限"];
//分段 表示前部分占比80%  所在值范围为[0,30]  即剩下的 20%滑动距离 值范围为[50，80]
slider.frontScale = 0.8;
slider.frontValue = 30;
slider.sliderValueChanged = ^(CGFloat minValue, CGFloat maxValue) {


};

slider.getMinTitle = ^NSString *(CGFloat minValue) {
if (floor(minValue) == 0.f) {
return @"不限";
}else{
return [NSString stringWithFormat:@"%.fK",floor(minValue)];
}  

};

slider.getMaxTitle = ^NSString *(CGFloat maxValue) {
if (floor(maxValue) == 80.f) {
return @"不限";
}else{
return [NSString stringWithFormat:@"%.fK",floor(maxValue)];
}
};

````

