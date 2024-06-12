# Image-resizing-algorithm
The proposed algorithm for doubling the size of images, which is implemented as a function inside MATLAB
The proposed algorithm works in such a way that, first of all, using the edge function in MATLAB, we obtain the edges of the input image, which is a matrix with the size of the input image, and the values ​​of each pixel are 1 or 0, where the number 1 represents is the edge
After defining the edge, the algorithm is divided into three parts
In the first part, place the pixels of the image that correspond to the pixels of the original image
and since we are going to double the size of the picture, therefore a quarter of the pixels of the image are set. Which in the figure below is an example for the Cameraman photo, 64
The pixel is in the top left corner

![Screenshot 2024-06-12 222442](https://github.com/falakian/Image-resizing-algorithm/assets/107622368/b05439ae-95d5-4a88-bc1c-5ab5d8f25cd3)

In the second part of the algorithm, we value the central pixels, which according to their location, their distance from each of its four neighbors is equal, and each of these pixels according to the value of the four neighbors In the edge matrix that we calculated, we divide it into the following 5 states. This division is based on the number of 1's that have 4 pixel neighbors.

![Screenshot 2024-06-12 222412](https://github.com/falakian/Image-resizing-algorithm/assets/107622368/2c0f382e-447f-4c95-b457-563976aaff0f)

In modes 1, 3 and 5, we set the value of the pixel equal to the average of its 4 neighbors, because in mode 1 there is no edge and the distance of this pixel is equal to its 4 neighbors, so we set the average value or In mode 5, the desired pixel is most likely located inside the edge in the enlarged image, and we have to place the average of the pixels around it, and in the third mode, the desired pixel is included in the edge, and it is also included in the edge. Average mode is a good way to calculate pixel brightness.
But in case 2 and 4, the desired pixel is located on the edge, and we should not consider the value of the neighboring pixel that is not on the edge, and since it becomes zero and one with the positions of the values, it guessed the direction of the edge. We place the pixel equal to the two neighboring pixels that are in the direction of the edge
In the image below for the Cameraman photo, you can see the 64 pixels in the upper left corner

![Screenshot 2024-06-12 223116](https://github.com/falakian/Image-resizing-algorithm/assets/107622368/17caa845-f3fe-445b-8135-43386b09c543)

The pixels that are green are assigned values ​​in the third part, the process is similar to the second part, with the difference that the top and bottom, left and right pixels are used for the neighboring pixels, and two pixels out of these 4 pixels in The second part was calculated.

So you can see the final pixel value for the Cameraman photo, 64 pixels in the upper left corner in the figure below

![Screenshot 2024-06-12 223203](https://github.com/falakian/Image-resizing-algorithm/assets/107622368/c5e312db-7f2b-4510-b203-8ac62a180dca)

Table and comparison of the proposed method with other methods

![Screenshot 2024-06-12 223441](https://github.com/falakian/Image-resizing-algorithm/assets/107622368/f81f311a-f014-45ca-b2c4-f80dc69358d1)
