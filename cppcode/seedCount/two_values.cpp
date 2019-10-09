#include <opencv2/core.hpp>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>

using namespace cv;
int main(){
    Mat img = imread("seed.jpg", IMREAD_UNCHANGED);
    Mat gray_img;
    cvtColor(img, gray_img, CV_BGR2GRAY);
    Mat bin_img;
    // threshold(gray_img, bin_img, 0, 255, THRESH_BINARY|THRESH_OTSU);
    // ↓周囲の明るさに応じて自動的に二値化できる（今回の場合、99×99）
    adaptiveThreshold(gray_img, bin_img, 255, CV_ADAPTIVE_THRESH_GAUSSIAN_C, CV_THRESH_BINARY, 99, 8); 

    bin_img = ~bin_img; //色の反転

    Mat element = Mat::ones(5,5,CV_8UC1); //5×5の行列で要素はすべて1　erode処理に必要な行列
    //以下4行は同じことを4回繰り返しています
    erode(bin_img, bin_img, element, Point(-1,-1), 1); //収縮処理
    erode(bin_img, bin_img, element, Point(-1,-1), 1); //収縮処理
    erode(bin_img, bin_img, element, Point(-1,-1), 1); //収縮処理
    erode(bin_img, bin_img, element, Point(-1,-1), 1); //収縮処理

    Mat dst = cv::Mat::ones(bin_img.rows * 0.2, bin_img.cols * 0.2, CV_8U);
    resize(bin_img, dst, dst.size(), INTER_CUBIC);
    //ウィンドウの表示形式の設定
    namedWindow("IMAGE", WINDOW_AUTOSIZE);
    imshow("IMAGE",dst);
    waitKey(10000);
    return 0;
}