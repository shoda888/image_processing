#include <opencv2/core.hpp>
#include <opencv2/highgui.hpp>

using namespace cv;
int main(){
    Mat img = imread("seed.jpg", IMREAD_UNCHANGED);
    imshow("IMAGE",img);
    waitKey(10000);
    return 0;
}