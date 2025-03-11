from data import Data
from crp import CRP
from numpy import sum
from numpy import sqrt
from numpy import log
import matplotlib.pyplot as plt

class Evalue():
  
  clss_size = {}
  diff_c = {}
  M_dis1 = {}
  M_dis2 = {}
  iteration = 0
  
  def __init__(self):
    pass

  @staticmethod
  def dovalue():
    it = Evalue.iteration
    Evalue.iteration += 1
      
    Evalue.clss_size[it] = len(Data.get_all_class_id())
    # Diff class number
    class_size = len(Data.get_all_class_id()) 
    data_size = len(Data.get_all_data_id())
    Evalue.diff_c[it] = class_size - CRP.alpha * log(1 + data_size / CRP.alpha)

    # M_dis1
    x_paras = [ CRP.classpara[_i][0] for _i in CRP.classpara.keys()]
    y_paras = [ CRP.classpara[_i][1] for _i in CRP.classpara.keys()]
    
    x2_paras = [ x*x for x in x_paras]
    y2_paras = [ y*y for y in y_paras]

    s = 0.0
    for _i in range(len(x2_paras)):
      s = s + sqrt( x2_paras[_i] + y2_paras[_i])
    Evalue.M_dis1[it] = s

    # M_dis2
    all_class_id = Data.get_all_class_id()
    all_data_id = Data.get_all_data_id()
    mu_x = {}
    mu_y = {}
    for _cid in all_class_id :
      _class_data_id = Data.get_class_data(_cid)
      _len = len(_class_data_id)
      _x_datas = [ Data.getxdata(_i) for _i in _class_data_id] 
      _y_datas = [ Data.getydata(_i) for _i in _class_data_id]

      mu_x[_cid] = sum(_x_datas) / _len
      mu_y[_cid] = sum(_y_datas) / _len

    s = 0.0
    for _did in all_data_id:
      _cid = Data.get_data_class(_did)
      _x_val = Data.getxdata(_did)
      _y_val = Data.getydata(_did)
      _dx = _x_val - mu_x[_cid]
      _dy = _y_val - mu_y[_cid]
      s += sqrt(_dx*_dx + _dy*_dy) 
      
    Evalue.M_dis2[it] = s


  @staticmethod
  def show_evaluation():
    # Plot Data
    plt.figure(1)

    x_values = []
    y_values = []
    for _did in Data.get_all_data_id():
      x_values.append(Data.getxdata(_did))
      y_values.append(Data.getydata(_did))
    
    plt.plot(x_values, y_values, 'ro')
    plt.title(' Data ')

    # Plot Evaluation
    plt.figure(2)

    # Plot Diff_c
    x_values = Evalue.diff_c.keys()
    y_values = []
    for _it in x_values:
      y_values.append(Evalue.diff_c[_it])
    
    plt.subplot(411)
    plt.plot(x_values, y_values, 'k')
    plt.ylabel(' D(K;a)')
    plt.xlabel(' Iteration ')

    # Plot M_dis1
    y_values = []
    for _it in x_values : 
      y_values.append(Evalue.M_dis1[_it])

    plt.subplot(412)
    plt.plot(x_values, y_values, 'k')
    plt.ylabel(' M-dis1')
    plt.xlabel(' Iteration ')

    # Plot M_dis2
    y_values = []
    for _it in x_values : 
      y_values.append(Evalue.M_dis2[_it])

    plt.subplot(413)
    plt.plot(x_values, y_values, 'k')
    plt.ylabel(' M-dis2')
    plt.xlabel(' Iteration ')

    # Plot Class number
    y_values = []
    for _it in x_values : 
      y_values.append(Evalue.clss_size[_it])

    plt.subplot(414)
    plt.plot(x_values, y_values, 'k')
    plt.ylabel(' Class number')
    plt.xlabel(' Iteration ')
    
    plt.show()







