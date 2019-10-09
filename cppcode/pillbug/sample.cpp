#include <opencv2/core.hpp>
#include <opencv2/highgui.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <iostream>

using namespace cv;
using namespace std; 

int main(){
    Mat img;
    VideoCapture cap("/home/shoda/Documents/sample/cppcode/pillbug/pillbug.mp4");
    int max_frame=cap.get(CV_CAP_PROP_FRAME_COUNT);
    for(int i=0; i<max_frame;i++){
        cap>>img;
        imshow("Video",img);
        waitKey(1);
    }
    return 0;
}