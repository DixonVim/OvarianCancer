# A Wavelet-based Method for Early Detection of Ovarian Cancer
## Overview
In this project, a new modality is proposed for early detection of ovarian cancer. The new modality uses self-similarity nature of protein mass spectra
for defining discrimonatory descriptors which can be used to detect the presence of cancer. Self-similarity of protein mass spectra is assessed in the wavelet domain 
by computing their wavelet spectra. A distance variance-based method is proposed as a novel approach for computing wavelet spectra as it is more robust to outliers and noise typically present.
Slope of the wavelet spectrum characterizes the interplay among protein expression levels, which can indicate cancer presence.

## Dataset
The data used in the project available at the [American National Cancer Institute Internet Repository](https://home.ccr.cancer.gov/ncifdaproteomics/ppatterns.asp). 
Two datasets namely `Ovarian 4-3-02` (**100 cases and 100 controls**) and `Ovarian 8-7-02` (**162 cases and 91 controls**) were used to validate the proposed modality. 

## Matlab Implementation 
In the following, the steps are explained based on the dataset `Ovarian 4-3-02`.
1. **Load Data:** `DataRead_4_3_02.m` reads data from the dataset `Ovarian 4-3-02`and then stores as `ovarian12.mat`. 

2. **Classifying Features:** `ComputeSlop_4_3_02.m` computes wavelet spectra locally via a rolling window-based approach under the 
standard variance and distance variance methods. This results in a collection of slopes, which are used as  descriminatory descriptors. 
The spectral slopes are stored as `SlopeDataset4_3_2.mat`. The **Fisher's Criteria** is then used to select the most significant descriptors for the classifiers.

3. **Classifiers:** Three different classifires, **Logistic Regression, Support Vector Machine**, and **K-Nearest Neighbor** are used in 
`OvarianJointclassify.m` to perform classification. 

4. **Detection Of Cancer:** `Demo_Dataset_4_3_03.m` performs the following classifications and performance is evaluated by computing three performance measures, classfication accuracy, sensitivity, and specificity.

  i. **Proposed Modality:** using the descriptors computed from the standard variance and distance variance based methods.
  
  ii. **Direct Method:** using features selected by applying the Fisher's criteria on the protein mass spectra. 
  
  iii. **Joint Method:** integrating features from  both the proposed method and the direct method.
  
**Note:** The same procedure is perfromed on the `Ovarian 8-7-02` dataset using the codes named with `8-7-02`. 

## Additional Evaluations
The `MatchWindowFeature_4_3_2.m` and `MatchWindowFeature_8_7_2.m` provide information about the location of the most significant descriptors in the protein mass spectra.
The significant features correspond to the proposed method and direct method are displayed as regions (due to window-based method) and dashed lines on the protein mass spectra, respectively.

## Outcomes
1. The proposed modality contributes to improvement in diagnostic performance for early detection. 
2. Compared to the existing Ovarial cancer detection methods, the proposed modality has improved generalizability and reproducibility as it requires minimal pre-processing!.
