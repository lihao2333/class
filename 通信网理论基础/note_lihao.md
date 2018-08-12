* 负指数分布
	* 伽玛分布的特例
	* 无记忆性
	* 用于分析泊松过程
* [泊松分布](http://www.ruanyifeng.com/blog/2015/06/poisson-distribution.html)
	* 某些事情,有固定频率,却不知何时发生.泊松分布就是描述某段时间内,时间具体的发生概率
	* 泊松分布是单位时间内独立事件发生次数的概率分布,指数分布是独立事件的时间间隔的概率分布
* Erlang Distribution,Phase-Type的一个特例
	* 相比于指数分布，爱尔朗分布能更好地对现实数据进行拟合 
* 平稳过程
	* [例子](https://baike.baidu.com/item/%E5%B9%B3%E7%A8%B3%E8%BF%87%E7%A8%8B/967659?fr=aladdin)
	* [The probability laws that govern the behavior of thr process do not change over time](https://www.zhihu.com/question/21982358)
	* 强平稳不一定是若平稳,因为其矩不一定存在
	* 金融领域很多东西之所以难以估计,就是因为其经常突变,根本就不是平稳的
* Markov Chain
	* chain->状态转移矩阵
	* Process:将来的状态只取决于现在,跟过去无关
		* 在已经知道过程now的条件下,其feture不依赖与past
* 生灭过程
	* 每一次转移都发生在相邻状态之间的齐次马氏链
	* 有离散时间的,也有连续时间的
	* 特殊的离散化状态的连续时间马尔可夫过程
	* 连续时间的马尔可夫链

