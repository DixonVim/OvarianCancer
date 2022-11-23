# A Wavelet-based Method for Early Detection of Ovarian Cancer
## Overview
This project proposes a new method for detecting ovarian cancer in its early stages. Based on the self-similarity of protein mass spectra, this novel method defines discriminatory descriptors that can be used to detect the presence of cancer. Wavelet spectra are used to assess the self-similarity of protein mass spectra in the wavelet domain. A distance variance-based method is proposed as a novel method for computing wavelet spectra because it is more robust to outliers and noise. The slope of the wavelet spectrum reflects the interplay between protein expression levels, which indicates the presence of cancer. 

## Dataset
The data used in the project available at the [American National Cancer Institute Internet Repository](https://home.ccr.cancer.gov/ncifdaproteomics/ppatterns.asp). 
Two datasets namely `Ovarian 4-3-02` (**100 cases and 100 controls**) and `Ovarian 8-7-02` (**162 cases and 91 controls**) were used to validate the proposed modality. Each protein mass spectra consists of the intensities of 15,153 peptides defined by their mass-to-charge ratio (i.e. the ratio of molecular weight to electrical charge) (M/z).


## Methods
### Proposed Method
 The proposed method assesses self-similarity of protein mass spectra in the wavelt-domain and define descriminatory descriptors to identify diagnostic features in protein mass spectra. The following concepts/methods are used in this method.
 
1. **Wavelet Transform:** a standard signal processing tool decomposes protein mass spectra into a hierarchy of resolutions convenient for assessing self-similarity. 
2. **Self-Similarity:** a phenomenon characterizes the stochastic similarity in protein mass spectra when viewed at different resolution scales.
3. **Standard Wavelet Spectra:** consists of wavelet log-energies (logarithm of average of squared wavelet coefficients) as a function of resolution level. The regular decay (slope) in wavelet energies with a increase of resolution indicates self-similarity. 
5. **Distance Variance:**  the standard wavelet spectra is sensitive to outliers and noise typically present in protein mass spectra. The distance variance-based method is proposed to assess self-similarity more precisely.

By using a rolling window-based approach, we compute wavelet spectra of protein mass spectra and estimate their slopes. As a result, a collection of slopes is generated, which serve as discriminatory descriptors. Using the standard variance and distance variance of the detail wavelet coefficients, we can estimate the slope by computing the wavelet spectrum. Fisher's criterion is then applied to select the most significant spectral descriptors.  

### Direct Method
The Fisher's criteria is applied on the original protein mass spectra to select features with large differences in mean intensity values  between cases and controls at each mass-to-chage ratio values.

## Matlab Implementation 
The following steps are explains procedure use to detect the presence of cancer on the basis of dataset `Ovarian 4-3-02`.
1. **Load Data:** `DataRead_4_3_02.m` reads data from the dataset `Ovarian 4-3-02`and then stores as `ovarian12.mat`. 

2. **Classifying Features:** `ComputeSlop_4_3_02.m` computes wavelet spectra and estimates slopes under the 
standard variance and distance variance methods. The spectral slopes are stored as `SlopeDataset4_3_2.mat`. 

3. **Classifiers:** Three different classifires, **Logistic Regression, Support Vector Machine**, and **K-Nearest Neighbor** are used in 
`OvarianJointclassify.m` to perform classification. 

4. **Detection Of Cancer:** `Demo_Dataset_4_3_03.m` performs the following classifications, and performance is evaluated by computing three performance measures, classfication accuracy, sensitivity, and specificity.

  i. **Proposed Modality:** using the descriptors computed from the standard variance and distance variance based methods.
  
  ii. **Direct Method:** using features selected by applying the Fisher's criteria on the protein mass spectra. 
  
  iii. **Joint Method:** integrating features from  both the proposed method and the direct method.
  
**Note:** The same procedure is perfromed on the `Ovarian 8-7-02` dataset using the codes named with `8-7-02`. 

## Additional Evaluations
The `MatchWindowFeature_4_3_2.m` and `MatchWindowFeature_8_7_2.m` provide information about the location of the most significant descriptors in the protein mass spectra.
The significant features correspond to the proposed method and direct method are displayed as regions (due to window-based method) and dashed lines on the protein mass spectra, respectively.

## Outcomes
1. The proposed modality contributes to improvement in diagnostic performance for early detection. 
2. Compared to the existing Ovarial cancer detection methods, the proposed modality has improved generalizability and reproducibility as it requires minimal pre-processing!

**Note:** Interested readers are encouraged to read the [original manuscript](https://doi.org/10.48550/arXiv.2207.07028).

