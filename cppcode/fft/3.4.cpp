// 3.4.cpp : このファイルには 'main' 関数が含まれています。プログラム実行の開始と終了がそこで行われます。
//

/*逆フーリエ変換*/
// #include "pch.h"
#define _USE_MATH_DEFINES
#include <iostream>
#include <cmath>
using namespace std;

double f1 = 15.0;
double f2 = 7.0;
double f3 = 5.0;

double dt = 0.01;
double df = 1.0;

double a = 0.0;
double b = 0.0;
double f = 0.0;

int main()
{
    // for (int i = 0; i <=99; i++) {
        for (int m = 0; m <= 50; m++) {
            for (int n = 0; n <= 99; n++) {
                double fs = (2.0 / 100.0)*(2.0*sin(2.0*M_PI*f1*dt*n) + 0.5*cos(2.0*M_PI*f2*dt*n) + 10.0*sin(2.0*M_PI*f3*dt*n))*sin(2.0 * M_PI*df*m*dt*n);
                double fc = (2.0 / 100.0)*(2.0*sin(2.0*M_PI*f1*dt*n) + 0.5*cos(2.0*M_PI*f2*dt*n) + 10.0*sin(2.0*M_PI*f3*dt*n))*cos(2.0 * M_PI*df*m*dt*n);

                a += fs;
                b += fc;

            }//フーリエ係数a,b完成

            // double ff = a * sin(2.0 * M_PI*df*m*dt*i) + b * cos(2.0 * M_PI*df*m*dt*i);
            // f += ff;

            cout << a << endl;
            a = 0;
        // cout << b << endl;
        }//元式f(i)完成
    // cout << f << endl;
    // printf("%f,%e\n", dt*i, f);
    // }
            return 0;
}

// プログラムの実行: Ctrl + F5 または [デバッグ] > [デバッグなしで開始] メニュー
// プログラムのデバッグ: F5 または [デバッグ] > [デバッグの開始] メニュー

// 作業を開始するためのヒント: 
//    1. ソリューション エクスプローラー ウィンドウを使用してファイルを追加/管理します 
//   2. チーム エクスプローラー ウィンドウを使用してソース管理に接続します
//   3. 出力ウィンドウを使用して、ビルド出力とその他のメッセージを表示します
//   4. エラー一覧ウィンドウを使用してエラーを表示します
//   5. [プロジェクト] > [新しい項目の追加] と移動して新しいコード ファイルを作成するか、[プロジェクト] > [既存の項目の追加] と移動して既存のコード ファイルをプロジェクトに追加します
//   6. 後ほどこのプロジェクトを再び開く場合、[ファイル] > [開く] > [プロジェクト] と移動して .sln ファイルを選択します