visdial_v=1.0
loss_type=mlm
split=train
len_vis_input=36
use_num_imgs=-1
bs=30

checkpoint_output=v${visdial_v}_${loss_type}_gen_g1

export CUDA_VISIBLE_DEVICES=1

WORK_DIR=.
export CHECKPOINT_ROOT=${WORK_DIR}/checkpoints
export PYTHONPATH=${WORK_DIR}:${PYTHONPATH}
model_path=${CHECKPOINT_ROOT}/saved_models/v1.0_from_BERT_e30.bin

python vdbert/train_visdial.py \
    --output_dir ${CHECKPOINT_ROOT}/${checkpoint_output} \
    --model_recover_path ${model_path} --len_vis_input ${len_vis_input}  \
    --do_train --new_segment_ids --enable_butd --visdial_v ${visdial_v} \
    --src_file ${WORK_DIR}/data/visdial_${visdial_v}_${split}.json \
    --image_features_hdfpath ${WORK_DIR}/data/img_feats1.0/visdial_img_feat.lmdb \
    --s2s_prob 1 --bi_prob 0 --loss_type ${loss_type} --max_pred 5 --neg_num 0 --multiple_neg 0 \
    --inc_full_hist 1  --max_len_hist_ques 200 --max_len_ans 10 --only_mask_ans 1 \
    --num_workers 1 --train_batch_size ${bs}  --use_num_imgs ${use_num_imgs} --num_train_epochs 10 \
    --local_rank -1 --global_rank -1 --world_size 1

# --image_features_hdfpath ${WORK_DIR}/data/img_feats1.0/${split}.h5 \
